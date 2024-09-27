//
//  CreateAddAnalyInstructionView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/25/24.
//

import SwiftUI

struct CreateAddAnalyInstructionView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    
    @State fileprivate var analyInstruction: AnalyzedInstruction = AnalyzedInstruction()
    
    
    fileprivate func addInstruction() {
        guard !analyInstruction.name.isEmpty else { return }
        
#if DEBUG
        print("currentRecipe.recipeUUID: ", userData.userRecipes.currentRecipe.recipeUUID)
        print("analyInstruction: ", analyInstruction)
#endif
            userData.analyzedInstructions.add(analyInstruction)
        
        userData.userRecipes.currentRecipe.analyzedInstructions.append(analyInstruction)
#if DEBUG
        print("Added the Analyzed Instruction to the current recipe ", userData.userRecipes.currentRecipe)
#endif

    }
    
    var body: some View {
        
        VStack {
            Text("Analyzed Instructions").font(.headline)
                .padding()
            
            TextField("Instruction description", text: $analyInstruction.name)
                .border(Color.black, width: 1)
                .padding()
            
            List {
                if userData.stepList.steps.isEmpty {
                    Text("No Steps Found")
                } else {
                    ForEach(userData.stepList.steps.sorted(), id: \.self) { step in
                        VStack {
                            Text("Step " + step.number.description + ". " + step.step )
                        }
                    }
                }
            }
//            List {
//                Text("Instructions")
//                ForEach(userData.analyzedInstructions.instructions, id: \.self) { instruction in
//                    VStack {
//                        Text(instruction.name)
//                    }
//                }.disabled(userData.analyzedInstructions.instructions.isEmpty)
//            }
            
            Button("Add all steps to instruction") {
                analyInstruction.steps.append(contentsOf: userData.stepList.steps)
#if DEBUG
                print("Added all steps to: ", analyInstruction.name)
#endif
                
                userData.userRecipes.currentRecipe.analyzedInstructions.append(analyInstruction)
#if DEBUG
                print("Added analyzed instruction to current recipe", userData.userRecipes.currentRecipe.title)
#endif
                userData.analyzedInstructions.add(analyInstruction)
                userData.analyzedInstructions.upDateAInstr()
//                userData.stepList.upDateSteps()
#if DEBUG
                print("AddAllSteps, Updated step list via upDateSteps")
#endif

            }
            .padding()
            .disabled(analyInstruction.name == "Please provide an instruction name")

            
        }.onAppear(perform:     {
            userData.analyzedInstructions.upDateAInstr()
        })
    }
}

#Preview {
    CreateAddAnalyInstructionView()
}
