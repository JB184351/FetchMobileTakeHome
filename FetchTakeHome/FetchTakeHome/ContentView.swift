//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    @State var recipes: [Recipe] = []
    @State private var cuisineTypes: Set<String> = []
    @State var selectedCuisineType: String? = nil
    let networkingManager = NetworkingManager.shared
    
    var body: some View {
        NavigationStack {
            Group {
                if recipes.count > 0 {
                    List {
                        ForEach(recipes, id: \.uuid) { recipe in
                            RecipeRowView(recipe: recipe)
                        }
                    }
                } else {
                    ContentUnavailableView {
                        Label("Could Not Load Recipes, press the refresh button to try again.", systemImage: "exclamationmark.triangle")
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu {
                        Picker("", selection: $selectedCuisineType) {
                            ForEach(cuisineTypes.sorted(by: <), id: \.self) { cuisineType in
                                Text(cuisineType).tag(cuisineType)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            selectedCuisineType = nil
                            try await self.loadRecipes()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                }
            }
            .task {
                do {
                    try await self.loadRecipes()
                } catch {
                    print(error)
                }
            }
            .refreshable {
                do {
                    try await self.loadRecipes()
                } catch {
                    print(error)
                }
                
                selectedCuisineType = nil
            }
            .onChange(of: selectedCuisineType) { oldValue, newValue in
                // Decided to call the network call because the data could
                // theoretically update on the backend at any time so
                // we always want to filter with the newest data available
                Task {
                    try await self.loadRecipes(with: newValue)
                }
            }
        }
    }
    
    private func loadRecipes(with filter: String? = nil) async throws {
        do {
            var recipes = try await networkingManager.loadRecipes()
            
            cuisineTypes = getAllCuisineTypes(from: recipes)
            
            if let filter = filter {
                recipes = recipes.filter { $0.cuisine.contains(filter) }
            }
            
            self.recipes = recipes
            
        } catch RecipeError.invalidURL {
            print("Invalid URL")
        } catch RecipeError.invalidResponse {
            print("Invalid Response")
        } catch RecipeError.invalidData {
            print("Invalid Data")
        } catch {
            print("Unexpected Error")
        }
    }
    
    private func getAllCuisineTypes(from recipes: [Recipe]) -> Set<String> {
        return Set(recipes.map { $0.cuisine } )
    }
}
