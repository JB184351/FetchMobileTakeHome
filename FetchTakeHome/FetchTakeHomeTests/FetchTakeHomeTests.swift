//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Justin on 2/20/25.
//

import Testing
@testable import FetchTakeHome

struct FetchTakeHomeTests {
    
    @Test("Testing if Recipe Response is correct")
    func downloadingRecipesYieldsExpectedValue() async {
        let recipes = await loadRecipes()
    }
}
