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

    init(ruuid: UUID) {
        // must link to recipe
        self.uuid = ruuid
    }
    
    @State fileprivate var steptext: String = ""
    fileprivate var uuid: UUID
    fileprivate var stepnumber: Int = 0
    fileprivate enum tabs: String {
        case ingredients = "Ingredients 🧆"
        case equipment = "Equipment 🍒"
    }
    
    fileprivate func addStep() {
        let step = Step(number: stepList.steps.count, step: steptext, ingredients: selectedIngredientsList.selectedIngredients, equipment: selectedEquipmentList.selectedEquipment, length: nil)
        stepList.addStep(step)
        print(stepList.steps)
    }
    
    fileprivate func checkRecipeExists() {
        
    }
    var body: some View {
        NavigationView {
            VStack  {
                TextField("Step description", text: $steptext)
                    .padding()
                    .border(Color.black, width: 1)
                    .padding()
                TabView {
                    ChooseIngredView().tabItem {
                        Image(uiImage: imageDocDocEmpty!)
                        Text(tabs.ingredients.rawValue)
                    }
                    
                    ChooseEquipmentView().tabItem {
                        Image(uiImage: imageDocDocEmpty!)
                        Text(tabs.equipment.rawValue)}
                    }
            }
            .navigationTitle("Create Step")
        }
        
        Button("Add Step") {
            addStep()
        }
    }
}

#Preview {
    CreateStepView(ruuid: UUID())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
