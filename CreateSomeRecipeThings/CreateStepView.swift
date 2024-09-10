//
//  CreateStepView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct CreateStepView: View {
    
    init(ruuid: UUID) {
        self.uuid = ruuid
    }
    
    @State fileprivate var steptext: String = ""
    @State fileprivate var ingredient: String = ""
    fileprivate var uuid: UUID
    
    fileprivate func addStep() {
        let step = Step(number: 1, step: steptext, ingredients: [], equipment: [], length: nil)
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
        }
    }
}

#Preview {
    CreateStepView(ruuid: UUID())
}
