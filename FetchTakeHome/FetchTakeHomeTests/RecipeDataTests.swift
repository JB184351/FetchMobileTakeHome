//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Justin on 2/20/25.
//

import Testing
import Foundation
@testable import FetchTakeHome

struct RecipeDataTests {
    
    @Test func decodesValidRecipeData() throws {
        let recipeJSON =
        """
        {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
        ]
        }
        """.data(using: .utf8)!
        
        let recipe = try JSONDecoder().decode(RecipeResponse.self, from: recipeJSON).recipes.first!
        
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.photoURLLarge == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(recipe.photoURLSmall == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(recipe.sourceURL == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(recipe.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(recipe.youtubeURL == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    @Test func failsToDecodeInvalidYouTubeURL() async throws {
        // Removed the sourceURL for this specific test
        let recipeJSON =
        """
        {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "invalid-youtube-url"
            }
        ]
        }
        """.data(using: .utf8)!
        
        #expect(throws: DecodingError.self) {
            _ = try JSONDecoder().decode(RecipeResponse.self, from: recipeJSON)
        }
    }
    
    @Test func decodeRecipesWithNullSourceURL() async throws {
        let recipeJSON =
        """
        {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": null,
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
        ]
        }
        """.data(using: .utf8)!
        
        let recipe = try JSONDecoder().decode(RecipeResponse.self, from: recipeJSON).recipes.first!
        
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.photoURLLarge == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(recipe.photoURLSmall == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(recipe.sourceURL == nil)
        #expect(recipe.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(recipe.youtubeURL == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
}
