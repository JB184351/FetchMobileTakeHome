//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import Foundation

struct Recipe: Codable, Hashable {
    let cuisine: String
    let cuisineName: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?
}
