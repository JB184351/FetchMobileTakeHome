//
//  File.swift
//  FetchTakeHome
//
//  Created by Justin on 3/19/25.
//

import Foundation

protocol RecipeRetrievableService {
    
    /// A Boolean value indicating whether the service is currently loading data.
    var isLoading: Bool { get }
    
    /// Asynchronously fetches an array of Recipes from the data source
    ///  - Returns: An array of `Recipe` objects
    ///  - Throws: An error if the operations fails
    func fetchRecipes() async throws -> [Recipe]
    
    /// Asynchronously fetches an empty array of Recipes from the data source
    /// Added this case due to having an example of an url that returns an empty array of recipes
    ///  - Returns: An empty array of `Recipe` objects
    ///  - Throws: An error if the operations fails
    func fetchEmptyRecipes() async throws -> [Recipe]
}
