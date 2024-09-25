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
#endif
            
            analyInstruction = AnalyzedInstruction(name: analyInstruction.name, steps: userData.stepList.steps, id: userData.userRecipes.currentRecipe.recipeUUID)
            
            userData.analyzedInstructions.add(analyInstruction)

    }
    
    var body: some View {
        
        VStack {
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
            
            Button("Add all steps to instruction") {
                analyInstruction.steps.append(contentsOf: userData.stepList.steps)
#if DEBUG
                print("Added all steps to: ", analyInstruction.name)
#endif
                userData.stepList.steps.removeAll()
#if DEBUG
                print("Removed all created steps")
#endif
                userData.userRecipes.currentRecipe.analyzedInstructions.append(analyInstruction)
#if DEBUG
                print("Added analyzed instruction to user recipe")
#endif
            }
            .padding()
            .disabled(analyInstruction.name == "Please provide an instruction name")
            
            
            Button("Add Instruction") {
#if DEBUG
                print("selectedIngredientsList.selectedIngredients.count ", userData.selectedIngredList.selectedIngredients.count.description)
                print("selectedEquipmentList.selectedEquipment.count ", userData.selectedEquipList.selectedEquipment.count.description)
                print("stepList.steps.count ", userData.stepList.steps.count.description)
#endif
                addInstruction()
            }
            .padding()
            .disabled(analyInstruction.name == "Please provide an instruction name")
            
        }
    }
}

#Preview {
    CreateAddAnalyInstructionView()
}
