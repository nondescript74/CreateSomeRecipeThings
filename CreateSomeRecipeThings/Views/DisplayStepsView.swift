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
                        VStack {
                            Text("Step " + step.number.description + ". " + step.step )
                            
                                ForEach(step.ingredients, id: \.self) { ingredient in
                                    HStack {
                                        Text(ingredient.name)
                                        Text(ingredient.amount?.number.description ?? "")
                                        Text(ingredient.amount?.unit.description ?? "none")
                                    }
                                }

                                
                            ForEach(step.equipment, id: \.self) { equipment in
                                Text(equipment.name)
                                    .background(Color.blue)
                            }.alignmentGuide(.leading, computeValue: { $0[.trailing] })
                        }

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
