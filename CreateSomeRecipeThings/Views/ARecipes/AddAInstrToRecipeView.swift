//
//  AddAInstrToRecipeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/26/24.
//

import SwiftUI

struct AddAInstrToRecipeView: View {
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    
    @State var selectedRecipe: Arecipe
    @State var ai: AnalyzedInstruction
    var body: some View {
        VStack {
            Text("Add an Instruction to the current recipe").font(.subheadline)
            Text("You've selected \(selectedRecipe.title)")
            
        }
    }
}

#Preview {
    AddAInstrToRecipeView(selectedRecipe: sampleRecipe, ai: sampleAnalyzedInstruction)
        .environmentObject(ARecipesList())
        .environmentObject(AnalyzedInstructionList())
}
