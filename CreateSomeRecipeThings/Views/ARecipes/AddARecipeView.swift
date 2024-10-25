//
//  AddARecipeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AddARecipeView: View {
    @EnvironmentObject var aRecipeList: ARecipesList
    @State private var recipeName: String = ""

    var body: some View {
        Text("Create a new recipe")
            .font(.title)
        
        VStack {
            TextField("Recipe Name", text: $recipeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

        }
        
        Button("Add") {
//            let newStep = Step(number: stepsList.getNextStepIDToUse(), step: stepName, ingredients: [], equipment: [], recipeUUID: UUID())
//            stepsList.saveStep(step: newStep)
        }
        
        Button("Remove") {
//            let stepToRemove = stepsList.steps.first { $0.step == stepName }
//            stepsList.deleteStep(step: stepToRemove!)
        }
    }
}

#Preview {
    AddARecipeView().environmentObject(ARecipesList())
}
