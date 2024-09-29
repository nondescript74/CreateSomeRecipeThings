//
//  StepsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct StepsView: View {
    @EnvironmentObject var stepsList: StepsList
    var body: some View {
        VStack {
            Text("StepList has " + stepsList.steps.count.description + " steps")
                .font(.title)
            ForEach(stepsList.steps, id: \.self) { step in
                Text(step.step)
            }
        }
    }
}

#Preview {
    StepsView().environmentObject(StepsList())
}
