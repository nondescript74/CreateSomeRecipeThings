//
//  StepDetailView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/18/24.
//

import SwiftUI

struct StepDetailView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    @State var myStep: Step
    
    init (step: Step) {
        self.myStep = step
    }
    var body: some View {
        Text(self.myStep.step)
        Text(self.myStep.recipeUUID.uuidString)
            .environmentObject(self.userData)
    }
}

#Preview {
    StepDetailView(step: Step(number: 10, step: "My Step", ingredients: [], equipment: [], recipeUUID: UUID()))
        .environmentObject(UserData())
}
