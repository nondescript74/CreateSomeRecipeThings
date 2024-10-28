//
//  SelectedIngredientsList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/11/24.
//

import Foundation

final class SelectedIngredientsList: ObservableObject {
    
    // MARK: - Publisher
    @Published var selectedIngredients: [Ingredient]
    @Published private(set) var shippedIngredients: [Ingredient]
    
    init() {
        self.selectedIngredients = []
        self.shippedIngredients = [
            Ingredient(id: 1, name: "Eggs", localizedName: "Eggs", image: "" )]
#if DEBUG
        print("Selected Ingredients Initialized:", self.selectedIngredients)
        print("Shipped Ingredients loaded: ", self.shippedIngredients.count.description, "\n")
#endif
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        if self.selectedIngredients.contains(where: { $0.id == ingredient.id }) { return }
        self.selectedIngredients.append(ingredient)
#if DEBUG
        print("Added: ", ingredient)
        print(self.selectedIngredients)
#endif
    }
    
    func removeIngredient(_ ingredient: Ingredient) {
        self.selectedIngredients.removeAll(where: { $0.id == ingredient.id })
#if DEBUG
        print("Removed: ", ingredient)
        print(self.selectedIngredients)
#endif
    }
}
