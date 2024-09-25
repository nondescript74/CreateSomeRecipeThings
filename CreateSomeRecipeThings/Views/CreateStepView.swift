//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    
    
    @State fileprivate var steptext: String = ""
    @State fileprivate var unit: String = "teaspoon"
    @State fileprivate var number: Int?
    @State fileprivate var analyInstruction: AnalyzedInstruction = AnalyzedInstruction()
    
    fileprivate let volumeUnits: [String] = ["teaspoon", "tablespoon", "cup", "pint", "quart", "gallon", "milliliter", "liter", "ounce", "pound", "gram", "kilogram"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    fileprivate func addStep() {
        guard !steptext.isEmpty else { return }
        
        if userData.userRecipes.currentRecipe.recipeUUID == nil  {
#if DEBUG
            print("currentRecipe.recipeUUID is nil")
            return
#endif
        } else {
            let myUUID =  userData.userRecipes.currentRecipe.recipeUUID
#if DEBUG
            print("currentRecipe.recipeUUID: ", userData.userRecipes.currentRecipe.recipeUUID!)
#endif
            
            let myStep = Step(number: userData.stepList.getNextStepIDToUse(), step: steptext, ingredients: userData.selectedIngredList.selectedIngredients, equipment: userData.selectedEquipList.selectedEquipment, recipeUUID: myUUID!)
            userData.stepList.saveStep(step: myStep)
            userData.selectedEquipList.selectedEquipment.removeAll()
            userData.selectedIngredList.selectedIngredients.removeAll()
            steptext = ""
#if DEBUG
            print("Steps: ",userData.stepList.steps)
            print("StepList: "," saved a step")
#endif
            
        }
    }
    
    fileprivate func addInstruction() {
        guard !analyInstruction.name.isEmpty else { return }
        
        if userData.userRecipes.currentRecipe.recipeUUID == nil  {
#if DEBUG
            print("currentRecipe.recipeUUID is nil")
            return
#endif
        } else {
#if DEBUG
            print("currentRecipe.recipeUUID: ", userData.userRecipes.currentRecipe.recipeUUID!)
#endif
            
            let myInstruction = AnalyzedInstruction(name: analyInstruction.name, steps: userData.stepList.steps, id: userData.userRecipes.currentRecipe.recipeUUID!)
        }
    }
    
    private func deleteStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = userData.stepList.steps[anIndex]
            userData.stepList.deleteStep(step: aStep)
        }
        userData.stepList.steps.removeAll()
        userData.stepList.upDateSteps()
    }
    
    
    var body: some View {
        VStack  {
            
            TextField("Instruction description", text: $analyInstruction.name)
                .border(Color.black, width: 1)
                .padding()
            
            Divider()
            
            VStack  {
                Text("Steps already created").font(.headline)
                List {
                    if userData.stepList.steps.isEmpty {
                        Text("No Steps Found")
                    } else {
                        ForEach(userData.stepList.steps.sorted(), id: \.self) { step in
                            VStack {
                                Text("Step " + step.number.description + ". " + step.step )
                            }
                            
                        }.onDelete(perform: deleteStep)
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
                Button("Add Instruction with created steps") {
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
        .environmentObject(userData)
    }
}

#Preview {
    CreateStepView()
        .environmentObject(UserData())
}
