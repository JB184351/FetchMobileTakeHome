//
//  NetworkingManager.swift
//  FetchTakeHome
//
//  Created by Justin on 2/21/25.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func loadRecipes(from urlString: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json) async throws") async throws -> [Recipe] {
        do {
            guard let url = URL(string: urlString) else {
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
