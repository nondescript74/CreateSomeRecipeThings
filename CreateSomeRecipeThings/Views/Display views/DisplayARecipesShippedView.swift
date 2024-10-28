//
//  DisplayARecipesShippedView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/27/24.
//

import SwiftUI

struct DisplayARecipesShippedView: View {
    let arecipesShipped = try! JSONDecoder().decode([Arecipe].self, from: Data(contentsOf: Bundle.main.url(forResource: "arecipes_shipped_list", withExtension: "json")!))

    var body: some View {
        VStack {
            Text("Display Recipes Shipped").font(.headline)
            List(arecipesShipped) { arecipe in
                VStack(alignment: .leading) {
                    Text(arecipe.title).font(.headline)
                    Text(arecipe.summary).font(.subheadline)
                }
            }            
        }
        
    }
}

#Preview {
    DisplayARecipesShippedView()
}
