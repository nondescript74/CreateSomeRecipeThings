//
//  AnalyzedInstructionList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/24/24.
//

import Foundation

class AnalyzedInstructionList: ObservableObject {
    
    @Published var instructions: [AnalyzedInstruction]
    
    init() {
        self.instructions = []
#if DEBUG
        print("Initialized: ", self.instructions)
#endif
    }
    
    @MainActor
    func add(_ instruction: AnalyzedInstruction) {
        if self.instructions.contains(where: { $0.id == instruction.id }) {
            remove(instruction)
        }
        self.instructions.append(instruction)
#if DEBUG
        print("Added: ", self.instructions)
#endif
    }
    
    func remove(_ instruction: AnalyzedInstruction) {
        self.instructions.removeAll(where: { $0.id == instruction.id })
#if DEBUG
        print("Removed: ", self.instructions)
#endif
    }
}
