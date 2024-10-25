//
//  AInstructionsView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AInstructionsView: View {
    @EnvironmentObject var aiList: AnalyzedInstructionList
    
    var body: some View {
        VStack {
            Text("There are " + aiList.instructions.count.description + " instructions")
                .font(.title)
            ForEach(aiList.instructions, id: \.self) { ai in
                Text(ai.name + ": " + ai.steps.count.description + " steps")
            }
        }
    }
}

#Preview {
    AInstructionsView().environmentObject(AnalyzedInstructionList())
}
