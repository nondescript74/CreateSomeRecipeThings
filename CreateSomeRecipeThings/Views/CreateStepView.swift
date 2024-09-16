//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    @ObservedObject var stepList: StepList
    @ObservedObject var selectedIngredientsList: SelectedIngredientsList
    @ObservedObject var selectedEquipmentList: SelectedEquipmentList

    init(ruuid: UUID) {
        // must link to recipe
        self.uuid = ruuid
        self.selectedIngredientsList = .init()
        self.self .selectedEquipmentList = .init()
        self.stepList = .init()
    }
    
    @State fileprivate var steptext: String = ""
    @State fileprivate var ingredient: String = ""
    fileprivate var uuid: UUID
    
    fileprivate func addStep() {
        
        let step = Step(number: 1, step: steptext, ingredients: selectedIngredientsList.selectedIngredients, equipment: selectedEquipmentList.selectedEquipment, length: nil)
        print(step)
    }
    
    fileprivate func checkRecipeExists() {
        
    }
    var body: some View {
        VStack {
            Text("Enter the step description")
            TextField("Step description", text: $steptext)
                .padding()
                .border(Color.black, width: 1)
            Button("Add Step") {
                addStep()
            }
            
            
            ChooseIngredView()
                .padding()
            
            ChooseEquipmentView()
                .padding()
        }
    }
}

#Preview {
    CreateStepView(ruuid: UUID())
}
