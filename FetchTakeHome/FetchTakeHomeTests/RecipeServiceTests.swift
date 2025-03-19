//
//  RecipeServiceTests.swift
//  FetchTakeHomeTests
//
//  Created by Justin on 3/10/25.
//

import Testing
import Foundation
@testable import FetchTakeHome

struct RecipeServiceTests {
    @Test func fetchRecipesSuccessfully() async throws {
        // Given
        let mockService = MockRecipeService()
        
        // When
        let recipes = try await mockService.fetchRecipes()
        
        // Then
        #expect(recipes.count == 2)
        #expect(recipes[0].cuisine == "Mexican")
        #expect(recipes[0].photoURLLarge == nil)
        #expect(recipes[0].photoURLSmall == nil)
        #expect(recipes[0].sourceURL == nil)
        #expect(recipes[0].uuid == "0001-0002-0003")
        #expect(recipes[0].youtubeURL == nil)
    }
    
    @Test func handlesError() async throws {
        // Given
        let mockService = MockRecipeService()
        mockService.shouldError = true
        
        // Then
        await #expect(throws: URLError.self) {
            _ = try await mockService.fetchRecipes()
        }
    }
    
    @Test func manageLoadingStateForRecipes() async throws {
        // Given
        let mockService = MockRecipeService()
        mockService.delayInSeconds = 0.1
        
        // Then initial state
        #expect(!mockService.isLoading)
        
        // When starting the request
        let task = Task {
            try await mockService.fetchRecipes()
        }
        
        // Give the task a moment to start
        try await Task.sleep(for: .milliseconds(50))
        
        // Then loading should be true during the request
        #expect(mockService.isLoading)
        
        // When the request completes
        _ = try await task.value
        
        // Then loading should be false after completion
        #expect(!mockService.isLoading)
    }
}

// MARK: - MockRecipeResponseService
class MockRecipeService: RecipeRetrievableService {
    private(set) var isLoading = false
    var shouldError = false
    var delayInSeconds: TimeInterval = 0
    
    let sampleRecipeResponse =
    RecipeResponse(recipes:
        [
            Recipe(cuisine: "Mexican", name: "Tacos", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, uuid: "0001-0002-0003", youtubeURL: nil),
            Recipe(cuisine: "Thai", name: "Yellow Curry", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, uuid: "0002-0002-0003", youtubeURL: nil)
        ]
    )
    
    func fetchRecipes() async throws -> [Recipe] {
        isLoading = true
        defer { isLoading = false }
        
        if delayInSeconds > 0 {
            try await Task.sleep(for: .seconds(delayInSeconds))
        }
        
        if shouldError {
            throw URLError(.notConnectedToInternet)
        }
        
        return sampleRecipeResponse.recipes
    }
}
