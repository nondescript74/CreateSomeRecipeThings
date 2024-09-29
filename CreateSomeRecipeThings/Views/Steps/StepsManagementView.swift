//
//  StepsManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct StepsManagementView: View {
    @StateObject var stepsList = StepsList()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    AddStepView()
                } label: {
                    Text("Add Step")
                }
                
                NavigationLink {
                    StepsView()
                } label: {
                    Text("Show Steps")
                }.disabled(stepsList.steps.isEmpty)
            }
            .padding()
        }.environmentObject(stepsList)
    }
}

#Preview {
    StepsManagementView().environmentObject(StepsList())
}
