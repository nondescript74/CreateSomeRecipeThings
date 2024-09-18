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

    init(ruuid: UUID) {
        // must link to recipe
        self.uuid = ruuid
    }
    
    @State fileprivate var steptext: String = ""
    fileprivate var uuid: UUID
    
    fileprivate func addStep() {
        let myStep = Step(number: stepList.getCountOfSteps() + 1, step: steptext, ingredients: selectedIngredientsList.selectedIngredients, equipment: selectedEquipmentList.selectedEquipment, length: .none)
        stepList.steps.append(myStep)
#if DEBUG
        print("Steps: ",stepList.steps)
#endif
        stepList.saveStep(step: myStep)
#if DEBUG
        print("StepList: "," saved a step")
#endif
    }
    
    var body: some View {
        VStack  {
            TextField("Step description", text: $steptext)
                .padding()
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
    CreateStepView(ruuid: UUID())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
