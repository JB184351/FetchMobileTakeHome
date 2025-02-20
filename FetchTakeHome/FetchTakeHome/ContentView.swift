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
        }
        .task {
            await loadRecipes()
        }
    }
    
    private func loadRecipes() async {
        do {
            guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            recipes = recipeResponse.recipes
        } catch {
            print(error)
            recipes = []
        }
    }
}

#Preview {
    ContentView()
}
