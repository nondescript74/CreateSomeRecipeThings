//
//  DisplayIngredientNamesView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/27/24.
//

import SwiftUI

struct DisplayIngredientNamesView: View {
    @State private var searchText: String = ""
    let ingredientsList = try! JSONDecoder().decode([Ingredient].self, from: Data(contentsOf: Bundle.main.url(forResource: "ingredients_list", withExtension: "json")!))
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .navigationTitle("Ingredients")
            
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return ingredientsList.map({$0.name.lowercased()})
        } else {
            return ingredientsList.map({$0.name.lowercased()}).filter { $0.contains(searchText.lowercased()) }
        }
    }
}


#Preview {
    DisplayIngredientNamesView()
}
