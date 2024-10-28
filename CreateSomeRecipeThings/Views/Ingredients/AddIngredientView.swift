//
//  AddIngredientView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/26/24.
//

import SwiftUI

struct AddIngredientView: View {
    @EnvironmentObject var ai: AnalyzedInstructionList
    @EnvironmentObject var ingredients: SelectedIngredientsList
    @State private var selection: Set<Ingredient> = []
    @State private var searchText: String = ""
    let ingredientsList = try! JSONDecoder().decode([Ingredient].self, from: Data(contentsOf: Bundle.main.url(forResource: "ingredients_list", withExtension: "json")!))
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return ingredientsList.map({$0.name})
        } else {
            return ingredientsList.map({$0.name.lowercased()}).filter { $0.contains(searchText.lowercased()) }
        }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    Text(name)
                }
            }
        }
        .searchable(text: $searchText)
    }
}
#if DEBUG
#Preview {
    AddIngredientView()
}
#endif
