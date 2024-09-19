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
    
    private func deleteStep(offsets: IndexSet) {
        offsets.forEach { stepList.steps.remove(at: $0) }
    }
    
    var body: some View {
        List {
            Text("Delete Steps")
                .font(.headline)
                .padding()
            
            ForEach(stepList.steps, id: \.self) { step in
                Text(step.step)
            }.onDelete(perform: deleteStep)
        }
    }
}

#Preview {
    DeleteStepsView()
}
