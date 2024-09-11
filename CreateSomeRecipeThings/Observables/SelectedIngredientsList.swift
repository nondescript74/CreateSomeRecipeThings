//
//  SelectedIngredientsList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/11/24.
//

import Foundation

class SelectedIngredientsList: ObservableObject {
    
    // MARK: - Publisher
    @Published var selectedIngredients: [Ingredient]
    
    init() {
        self.selectedIngredients = []
    }
    
    
    @MainActor
    func addIngredient(_ ingredient: Ingredient) {
        self.selectedIngredients.append(ingredient)
    }
    
    func removeIngredient(_ ingredient: Ingredient) {
        self.selectedIngredients.removeAll(where: { $0.id == ingredient.id })
    }
}
