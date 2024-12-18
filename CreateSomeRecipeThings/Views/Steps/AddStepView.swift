//
//  AddStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AddStepView: View {
    @EnvironmentObject var stepsList: StepsList
    @State private var stepName: String = ""

    var body: some View {
        Text("Create a new step")
            .font(.title)
        
        VStack {
            TextField("Step Name", text: $stepName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

        }
        
        Button("Add Step") {
            let newStep = Step(number: stepsList.getNextStepIDToUse(), step: stepName, ingredients: [], equipment: [], recipeUUID: UUID().uuidString)
            stepsList.saveStep(step: newStep)
        }
        
        Button("Remove Step") {
            let stepToRemove = stepsList.steps.first { $0.step == stepName }
            stepsList.deleteStep(step: stepToRemove!)
        }
    }
}

#Preview {
    AddStepView().environmentObject(StepsList())
}
