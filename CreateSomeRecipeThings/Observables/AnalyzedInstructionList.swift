//
//  AnalyzedInstructionList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/24/24.
//

import Foundation

class AnalyzedInstructionList: Observable {
    
    @Published var instructions: [AnalyzedInstruction]
    
    init() {
        self.instructions = []
#if DEBUG
        print("Initialized: ", self.instructions)
#endif
    }
}
