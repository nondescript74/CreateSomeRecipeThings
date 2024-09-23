//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var userRecipes: UserRecipes
    
    
    @State fileprivate var steptext: String = ""
    @State fileprivate var unit: String = "teaspoon"
    @State fileprivate var number: Int?
    
    fileprivate let volumeUnits: [String] = ["teaspoon", "tablespoon", "cup", "pint", "quart", "gallon", "milliliter", "liter", "ounce", "pound", "gram", "kilogram"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    fileprivate func addStep() {
        guard !steptext.isEmpty else { return }
        
        if userRecipes.currentRecipe.recipeUUID == nil  {
#if DEBUG
            print("currentRecipe.recipeUUID is nil")
            return
#endif
        } else {
            let myUUID =  userRecipes.currentRecipe.recipeUUID

            let myStep = Step(number: stepList.getNextStepIDToUse(), step: steptext, ingredients: selectedIngredientsList.selectedIngredients, equipment: selectedEquipmentList.selectedEquipment, recipeUUID: myUUID!)
            stepList.saveStep(step: myStep)
            selectedEquipmentList.selectedEquipment.removeAll()
            selectedIngredientsList.selectedIngredients.removeAll()
            steptext = ""
#if DEBUG
            print("Steps: ",stepList.steps)
            print("StepList: "," saved a step")
#endif
            
        }
    }
    
    var body: some View {
        VStack  {
            
            TextField("Step description", text: $steptext)
                .border(Color.black, width: 1)
                .padding()
            
            Button("Add Step") {
#if DEBUG
                print("selectedIngredientsList.selectedIngredients.count ", selectedIngredientsList.selectedIngredients.count.description)
                print("selectedEquipmentList.selectedEquipment.count", selectedEquipmentList.selectedEquipment.count.description)
#endif
                addStep()
            }
        }
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
        .environmentObject(stepList)
    }
}

#Preview {
    CreateStepView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
