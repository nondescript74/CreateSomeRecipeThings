//
//  DeleteStepsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/19/24.
//

import SwiftUI

struct DeleteStepsView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var userRecipes: UserRecipes
    
    private func deleteAStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = stepList.steps[anIndex]
            stepList.deleteStep(step: aStep)
        }
        stepList.steps.removeAll()
        stepList.upDateSteps()
    }
    
    var body: some View {
        VStack {
            Text("Delete Steps")
                .font(.headline)
                .padding()
            List {
                ForEach(stepList.steps.sorted(), id: \.self) { step in
                    Text(step.number.description + " " + step.step)
                }.onDelete(perform: deleteAStep)
            }
            
            Button("Remove all steps") {
                stepList.steps.removeAll()
            }
        }
    }
}

#Preview {
    DeleteStepsView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
