//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var userRecipes: UserRecipes
    
    
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
        
        if userRecipes.currentRecipe.recipeUUID == nil  {
#if DEBUG
            print("currentRecipe.recipeUUID is nil")
            return
#endif
        } else {
            let myUUID =  userRecipes.currentRecipe.recipeUUID
#if DEBUG
            print("currentRecipe.recipeUUID: ", userRecipes.currentRecipe.recipeUUID!)
#endif
            
            let myStep = Step(number: stepList.getNextStepIDToUse(), step: steptext, ingredients: selectedIngredientsList.selectedIngredients, equipment: selectedEquipmentList.selectedEquipment, recipeUUID: myUUID!)
            stepList.saveStep(step: myStep)
            selectedEquipmentList.selectedEquipment.removeAll()
            selectedIngredientsList.selectedIngredients.removeAll()
            steptext = ""
#if DEBUG
            print("Steps: ",stepList.steps)
            print("StepList: "," saved a step")
#endif
            
        }
    }
    
    fileprivate func addInstruction() {
        guard !analyInstruction.name.isEmpty else { return }
        
        if userRecipes.currentRecipe.recipeUUID == nil  {
#if DEBUG
            print("currentRecipe.recipeUUID is nil")
            return
#endif
        } else {
#if DEBUG
            print("currentRecipe.recipeUUID: ", userRecipes.currentRecipe.recipeUUID!)
#endif
            
            let myInstruction = AnalyzedInstruction(name: analyInstruction.name, steps: stepList.steps, id: userRecipes.currentRecipe.recipeUUID!)
        }
    }
    
    private func deleteStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = stepList.steps[anIndex]
            stepList.deleteStep(step: aStep)
        }
        stepList.steps.removeAll()
        stepList.upDateSteps()
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
                    if stepList.steps.isEmpty {
                        Text("No Steps Found")
                    } else {
                        ForEach(stepList.steps.sorted(), id: \.self) { step in
                            VStack {
                                Text("Step " + step.number.description + ". " + step.step )
                            }
                            
                        }.onDelete(perform: deleteStep)
                    }
                }
                
                
                
                Button("Add all steps to instruction") {
                    analyInstruction.steps.append(contentsOf: stepList.steps)
#if DEBUG
                    print("Added all steps to: ", analyInstruction.name)
#endif
                    stepList.steps.removeAll()
#if DEBUG
                    print("Removed all created steps")
#endif
                    userRecipes.currentRecipe.analyzedInstructions.append(analyInstruction)
#if DEBUG
                    print("Added analyzed instruction to user recipe")
#endif
                }
                .padding()
                .disabled(analyInstruction.name == "Please provide an instruction name")
                Button("Add Instruction with created steps") {
#if DEBUG
                    print("selectedIngredientsList.selectedIngredients.count ", selectedIngredientsList.selectedIngredients.count.description)
                    print("selectedEquipmentList.selectedEquipment.count ", selectedEquipmentList.selectedEquipment.count.description)
                    print("stepList.steps.count ",stepList.steps.count.description)
#endif
                    addInstruction()
                }
                .padding()
                .disabled(analyInstruction.name == "Please provide an instruction name")
            }
            
            
        }
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
        .environmentObject(stepList)
    }
}

#Preview {
    CreateStepView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
