//
//  AInstructionsManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AInstructionsManagementView: View {
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var ingredients: SelectedIngredientsList
    @EnvironmentObject var equipment: SelectedEquipmentList
    @EnvironmentObject var steps: StepsList
    
    var body: some View {
        NavigationStack {
            Section {
                AInstructionsView()
            } header: {
                VStack {
                    Text("Manage Instructions")
                        .font(.headline)
                    Text("The current recipe is \(recipesList.currentRecipe.title)")
                }
            }
            Divider()
            
            Section {
                NavigationLink {
                    AddAInstructionView()
                } label: {
                    Text("Add/Remove Instruction")
                }
            }
        }
        .environmentObject(recipesList)
        .environmentObject(aiList)
        .environmentObject(ingredients)
        .environmentObject(equipment)
        .environmentObject(steps)
    }
}

#Preview {
    AInstructionsManagementView()
        .environmentObject(AnalyzedInstructionList())
        .environmentObject(StepsList())
        .environmentObject(ARecipesList())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
}
/*
 struct ARecipesManagementView: View {
     @StateObject var ai = AnalyzedInstructionList()
     @StateObject var recipesList = ARecipesList()
     
     var body: some View {
         NavigationStack {
             Section {
                 RecipesView()
             } header: {
                 VStack {
                     Text("Manage Recipes")
                         .font(.headline)
                 }
             }
             Divider()
             
             Section {
                 NavigationLink {
                     AddAInstrToRecipeView(selectedRecipe: sampleRecipe, ai: sampleAnalyzedInstruction)
                 } label: {
                     Text("Add Instructions")
                 }
             }.padding()
             Divider()

             Section {
                 NavigationLink {
                     AddARecipeView()
                 } label: {
                     Text("Add Recipe")
                 }
             }
             
         }
         .environmentObject(recipesList)
         .environmentObject(ai)
     }
 }

 */
