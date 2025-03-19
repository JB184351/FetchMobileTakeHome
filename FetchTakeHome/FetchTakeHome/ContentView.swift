//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    @State var recipes: [Recipe] = []
    let networkingManager = NetworkingManager.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes, id: \.uuid) { recipe in
                    RecipeRowView(recipe: recipe)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            try await self.loadRecipes()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

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
        }
    }
    
    private func loadRecipes(with filter: String = "") async throws {
        do {
            recipes = try await networkingManager.loadRecipes()
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
}

#Preview {
    ContentView()
}
