//
//  ARecipesManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

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

#Preview {
    ARecipesManagementView()
        .environmentObject(ARecipesList())
        .environmentObject(AnalyzedInstructionList())
}
