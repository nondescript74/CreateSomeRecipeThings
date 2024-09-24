//
//  UserData.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/24/24.
//

import Foundation

class UserData: ObservableObject {
    @Published var userRecipes: UserRecipes
    @Published var analyzedInstructions: AnalyzedInstructionList
    @Published var selectedIngredList: SelectedIngredientsList
    @Published var selectedEquipList: SelectedEquipmentList
    @Published var stepList: StepList
    
    init() {
        self.userRecipes = UserRecipes()
        self.analyzedInstructions = AnalyzedInstructionList()
        self.selectedIngredList = SelectedIngredientsList()
        self.selectedEquipList = SelectedEquipmentList()
        self.stepList = StepList()
    }
}
