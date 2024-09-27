//
//  DeleteStepsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/19/24.
//

import SwiftUI

struct DeleteStepsView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    
    private func deleteAStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = userData.stepList.steps[anIndex]
            userData.stepList.deleteStep(step: aStep)
        }
        userData.stepList = .init()
    }
    
    var body: some View {
        VStack {
            Text("Delete Steps")
                .font(.headline)
                .padding()
            List {
                ForEach(userData.stepList.steps.sorted(), id: \.self) { step in
                    Text(step.number.description + " " + step.step)
                }.onDelete(perform: deleteAStep)
            }
            
            Button("Remove all steps") {
                userData.stepList.steps.removeAll()
            }
        }
    }
}

#Preview {
    DeleteStepsView()
        .environmentObject(UserData())
}
