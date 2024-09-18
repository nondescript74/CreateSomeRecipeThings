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
        
         
        
        List {
            if stepList.steps.isEmpty {
                Text("No Steps Found")
            } else {
                ForEach(stepList.steps, id: \.self) { step in
                    Text(step.number.description + ". " + step.step )
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
