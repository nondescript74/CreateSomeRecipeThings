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
    
    
    fileprivate let volumeUnits: [String] = ["teaspoon", "tablespoon", "cup", "pint", "quart", "gallon", "milliliter", "liter", "ounce", "pound", "gram", "kilogram"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    fileprivate func addStep() {
        guard !steptext.isEmpty else { return }
        let myUUID =  userData.userRecipes.currentRecipe.recipeUUID
#if DEBUG
        print("currentRecipe.recipeUUID: ", userData.userRecipes.currentRecipe.recipeUUID)
#endif
        
        let myStep = Step(number: userData.stepList.getNextStepIDToUse(), step: steptext, ingredients: userData.selectedIngredList.selectedIngredients, equipment: userData.selectedEquipList.selectedEquipment, recipeUUID: myUUID)
        userData.stepList.saveStep(step: myStep)
        userData.stepList = .init()
        userData.selectedEquipList.selectedEquipment.removeAll()
        userData.selectedIngredList.selectedIngredients.removeAll()
        steptext = ""
#if DEBUG
        print("Steps: ",userData.stepList.steps)
        print("StepList: "," saved a step")
#endif
        
    }
    
    
    private func deleteStep(offsets: IndexSet) {
        let setOfIndices = offsets.map(\.self)
        for anIndex in setOfIndices {
            let aStep = userData.stepList.steps[anIndex]
            userData.stepList.deleteStep(step: aStep)
        }
        userData.stepList = .init()
    }
    
    
    var body: some View {
        VStack  {
            VStack  {
                Text("Steps").font(.headline)
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
            }
            
            VStack  {
                Text("Create a new Step").font(.headline)
                TextField("Step Text", text: $steptext)
                
                Button(action: {
                    addStep()
                    
                }) {
                    Text("Add the step")
                }.disabled(steptext == "")
            }
            
            VStack  {
                HStack {
                    List {
                        if userData.selectedEquipList.selectedEquipment.isEmpty {
                            Text("No Equipment Selected")
                        } else {
                            ForEach(userData.selectedEquipList.selectedEquipment, id: \.self) { equip in
                                Text(equip.name)
                            }
                        }
                    }
                    
                    List {
                        if userData.selectedIngredList.selectedIngredients.isEmpty {
                            Text("No Ingredients Selected")
                        } else {
                            ForEach(userData.selectedIngredList.selectedIngredients, id: \.self) { ingred in
                                Text(ingred.name)
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(userData)
    }
}

#Preview {
    CreateStepView()
        .environmentObject(UserData())
}
