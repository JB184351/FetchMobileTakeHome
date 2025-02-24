//
//  RecipeRowView.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let urlString = recipe.photoURLSmall, let url = URL(string: urlString) {
                loadImage(from: url)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    func loadImage(from url: URL) -> some View {
        AsyncImage(url: url) { image in
            switch image {
            case .empty:
                ProgressView()
                    .frame(width: 60, height: 60)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            case .failure:
                Image(systemName: "photo")
                    .frame(width: 60, height: 60)
            @unknown default:
                EmptyView()
            }
        }

    }
}

#Preview {
    RecipeRowView(recipe: Recipe(cuisine: "Malaysian", name: "Apam Balik", photoURLLarge: nil, photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8", youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"))
}
