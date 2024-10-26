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
            Text("Add A Instruction To Recipe").font(.title)
        }
    }
}

#Preview {
    AddAInstrToRecipeView(selectedRecipe: sampleRecipe, ai: sampleAnalyzedInstruction)
        .environmentObject(ARecipesList())
        .environmentObject(AnalyzedInstructionList())
}


/*
 struct AddStepsToRecipeView: View {
     @EnvironmentObject var recipesList: ARecipesList
     @EnvironmentObject var stepsList: StepsList
     
     @State var selectedRecipe: Arecipe
     @State var step: Step
     
     var body: some View {
         VStack {
             Text("Add Steps and Links To Recipe").font(.title)
             VStack {
                 Text("You've selected \(selectedRecipe.title)")
                 Text("You've selected \(step.step)")
             }.padding()
             
             HStack {
                 Text("Select recipe").font(.subheadline)
                     .padding()
                 Picker("", selection: $selectedRecipe) {
                     ForEach(recipesList.userRecipes, id: \.self) { recipe in
                         Text(recipe.title)
                     }
                 }
             }
             Picker("Select step", selection: $step) {
                 ForEach(stepsList.steps, id: \.self) { step in
                     Text(step.step)
                 }
             }
             
             Button("Add Step To Recipe") {
                 stepsList.saveStep(step: step)
                 step = sampleStep
             }.disabled(selectedRecipe == sampleRecipe || step == sampleStep)
             
         }

     }
 }

 #Preview {
     AddStepsToRecipeView(selectedRecipe: sampleRecipe, step: sampleStep)
         .environmentObject(StepsList())
         .environmentObject(ARecipesList())
 }
 */
