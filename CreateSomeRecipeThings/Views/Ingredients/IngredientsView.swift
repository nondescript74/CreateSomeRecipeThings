//
//  IngredientsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/26/24.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var selectedIngredients: SelectedIngredientsList
    var body: some View {
        Text("Selected are " + selectedIngredients.selectedIngredients.count.description + " ingredients")
        ForEach(selectedIngredients.selectedIngredients, id: \.self) { ingredient in
            Text(ingredient.name)
        }.disabled(selectedIngredients.selectedIngredients.isEmpty)
    }
}
#if DEBUG
#Preview {
    IngredientsView()
        .environmentObject(SelectedIngredientsList())
}
#endif
