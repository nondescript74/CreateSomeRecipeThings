//
//  DeleteStepsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/19/24.
//

import SwiftUI

struct DeleteStepsView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    private func deleteAStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = stepList.steps[anIndex]
            stepList.deleteStep(step: aStep)
        }
        
    }
    
    var body: some View {
        List {
            Text("Delete Steps")
                .font(.headline)
                .padding()
            
            ForEach(stepList.steps, id: \.self) { step in
                Text(step.step)
            }.onDelete(perform: deleteAStep)
        }
    }
}

#Preview {
    DeleteStepsView()
}
