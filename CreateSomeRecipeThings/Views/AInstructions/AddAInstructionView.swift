//
//  AddAInstructionView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AddAInstructionView: View {
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var stepsList: StepsList
    @State private var aiName: String = ""

    var body: some View {
        Text("Create a new instruction")
            .font(.title)
        
        VStack {
            TextField("Instruction Name", text: $aiName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        
        Button("Add") {
            let newInstruction = AnalyzedInstruction(name: aiName, steps: stepsList.steps)
            aiList.save(newInstruction)
        }.disabled(aiName.isEmpty)
        
        Button("Remove") {
            let aiToRemove = aiList.instructions.first { $0.name == aiName }
            if aiToRemove == nil { return }
            aiList.remove(aiToRemove!)
        }.disabled(aiName.isEmpty)
    }
}

#Preview {
    AddAInstructionView().environmentObject(AnalyzedInstructionList())
}
