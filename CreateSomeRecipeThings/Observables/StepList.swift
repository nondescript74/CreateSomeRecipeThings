//
//  StepList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/11/24.
//

import Foundation

class StepList: ObservableObject {
    
    // MARK: - Publisher
    @Published var steps: [Step]
    
    init() {
        self.steps = []
    }
    
    
    @MainActor
    func addStep(_ step: Step) {
        self.steps.append(step)
    }
    
    func newAddStep(text: String) {
        let step = Step(number: steps.count + 1, step: text, ingredients: [], equipment: [], length: .none)
        self.steps.append (step)
    }
    
    
}
