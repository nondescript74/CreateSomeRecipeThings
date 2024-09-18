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
        stepList.addStep(text: steptext)
        #if DEBUG
        print(stepList.steps)
        #endif
    }
    
    var body: some View {
        VStack  {
            TextField("Step description", text: $steptext)
                .padding()
                .border(Color.black, width: 1)
                .padding()
            
            
            Button("Add Step") {
                addStep()
            }
            
//            List {
//                
//                ForEach(stepList.steps, id: \.self) { step in
//                    NavigationLink(destination: StepDetailView(step: step)) {
//                        Text(step.text)
//                    }
//                }
//
//            }
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
