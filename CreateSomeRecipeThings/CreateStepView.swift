//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    @ObservedObject var stepList: StepList = StepList.init()

    init(ruuid: UUID) {
        // must link to recipe
        self.uuid = ruuid
    }
    
    @State fileprivate var steptext: String = ""
    @State fileprivate var ingredient: String = ""
    fileprivate var uuid: UUID
    
    fileprivate func addStep() {
        var step = Step(number: 1, step: steptext, ingredients: [], equipment: [], length: nil)
        print(step)
    }
    
    fileprivate func checkRecipeExists() {
        
    }
    var body: some View {
        VStack {
            HStack  {
                TextField("Step description", text: $steptext)
                    .padding()
                Button("Add Step") {
                    addStep()
                }
                .padding()
            }
            HStack  {
                ChooseIngredView()
            }
        }
    }
}

#Preview {
    CreateStepView(ruuid: UUID())
}
