//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Justin on 2/20/25.
//

import Testing
import Foundation
@testable import FetchTakeHome

struct FetchTakeHomeTests {
    
    // I know this isn't a definitive test for ensuring
    // that we get all the recipe data validated but
    // it ensures us that we are getting something back
    // from the method we are using to load the recipes
    // Also attempted to add multiple arguments to test
    // the multiple urls given for the test but Xcode
    // wasn't playing nice so just defaulting the
    // all recipes endpoint
    @Test func recipeCount() async throws {
        let networkingManager = NetworkingManager.shared
        
        let recipes = try await networkingManager.loadRecipes()
        
        #expect(recipes.count > 0)
    }
    
    @Test func imageFetching() async throws {
        let recipe = Recipe(cuisine: "Malaysian", name: "Apam Balik", photoURLLarge: nil, photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8", youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        
        let recipeRowView = RecipeRowView(recipe: recipe)
        
        if let urlString = recipe.photoURLSmall, let url = URL(string: urlString) {
            #expect(await recipeRowView.loadImage(from: url) != nil)
        }
    }
}
