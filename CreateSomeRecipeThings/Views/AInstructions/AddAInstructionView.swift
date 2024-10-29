//
//  AddAInstructionView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AddAInstructionView: View {
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var stepsList: StepsList
    @State private var aiName: String = ""
    @State private var selection: String?
    
    var body: some View {
        Text("Create a new instruction")
            .font(.title)
        
        Text("Current recipe is " + "\(recipesList.currentRecipe.title)")
        
        VStack {
            TextField("Instruction Name", text: $aiName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        
        Button("Add") {
            let newInstruction = AnalyzedInstruction(name: aiName, steps: stepsList.steps)
            aiList.save(newInstruction)
            recipesList.currentRecipe.analyzedInstructions.append(newInstruction)
        }.disabled(aiName.isEmpty)
        
        Button("Remove") {
            let aiToRemove = aiList.instructions.first { $0.name == aiName }
            if aiToRemove == nil { return }
            aiList.remove(aiToRemove!)
            recipesList.currentRecipe.analyzedInstructions.removeAll { $0?.name == aiName }
        }.disabled(aiName.isEmpty)
        
        List(recipesList.userRecipes, id: \.self, selection: $selection) { arecipe in
            Text(arecipe.title).onTapGesture {
                recipesList.currentRecipe = arecipe
#if DEBUG
                print("Selected \(arecipe.title)")
#endif
            }
        }
    }
}

#Preview {
    AddAInstructionView().environmentObject(AnalyzedInstructionList())
}
