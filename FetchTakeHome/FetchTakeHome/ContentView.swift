//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Justin on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    var recipes: [Recipe] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...10, id: \.self) { _ in 
                    RecipeRowView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
