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
                StepsView()
            }
            NavigationLink {
                AddStepView()
            } label: {
                Text("Add a step")
            }
        }.environmentObject(stepsList)
    }
}

#Preview {
    StepsManagementView().environmentObject(StepsList())
}
