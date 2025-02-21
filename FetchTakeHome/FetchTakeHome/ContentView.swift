//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    @State var recipes: [Recipe] = []
 
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes, id: \.uuid) { recipe in
                    RecipeRowView(recipe: recipe)
                }
            }
            .navigationTitle("Recipes")
        }
        .task {
            do {
                recipes = try await loadRecipes()
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
    
    private func loadRecipes() async throws -> [Recipe] {
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        do {
            guard let url = URL(string: endpoint) else {
                throw RecipeError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw RecipeError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            return recipeResponse.recipes
        } catch {
            throw RecipeError.invalidData
        }
    }
}

#Preview {
    ContentView()
}
