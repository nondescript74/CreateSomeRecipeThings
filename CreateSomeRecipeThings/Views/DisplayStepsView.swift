//
//  DisplayStepsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/16/24.
//

import SwiftUI

struct DisplayStepsView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    
    var body: some View {
        VStack  {
            Text("Steps")
            List {
                if stepList.steps.isEmpty {
                    Text("No Steps Found")
                } else {
                    ForEach(stepList.steps.sorted(), id: \.self) { step in
                        Text("Step " + step.number.description + ". " + step.step )
                        #if DEBUG
                        Text(step.ingredients.count.description + " Ingredient(s)")
                        Text(step.equipment.count.description + " Equipment(s)")
                        #endif
                    }
                }
            }
        }
        .environmentObject(stepList)
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
        
    }
}

#Preview {
    DisplayStepsView()
        .environmentObject(StepList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
}
