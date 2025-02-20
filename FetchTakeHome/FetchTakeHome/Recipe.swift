//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String
    let cuisineName: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let uuid: String
    let sourceURL: String?
    let youtubeURL: String?
}
