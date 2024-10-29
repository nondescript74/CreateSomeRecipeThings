//
//  ARecipesManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct ARecipesManagementView: View {
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var ingredients: SelectedIngredientsList
    @EnvironmentObject var equipment: SelectedEquipmentList
    @EnvironmentObject var steps: StepsList
    
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
                    AddARecipeView()
                } label: {
                    Text("Add/Remove Recipe")
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
    ARecipesManagementView()
        .environmentObject(ARecipesList())
        .environmentObject(AnalyzedInstructionList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(StepsList())
}
