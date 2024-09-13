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
    @Published var currentStep: Step
    
    
    init() {
        self.steps = []
        self.currentStep = .init(number: 1, step: "First Step", ingredients: [], equipment: [], length: .none)
    }
    
    
    @MainActor
    func addStep(_ step: Step) {
        self.steps.append(step)
    }
    
    func removeStep(_ step: Step) {
        self.steps.removeAll(where: { $0.step == currentStep.step })
    }
}
