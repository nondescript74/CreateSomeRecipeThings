//
//  IngredientsManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/26/24.
//

import SwiftUI

struct IngredientsManagementView: View {
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var ingredients: SelectedIngredientsList
    @EnvironmentObject var equipment: SelectedEquipmentList
    @EnvironmentObject var steps: StepsList
    
    var body: some View {
        NavigationStack {
            Section {
                IngredientsView()
            } header: {
                VStack {
                    Text("Manage Ingredients")
                        .font(.headline)
                }
            }
            Divider()
            Section {
                NavigationLink {
                    AddIngredientView()
                } label: {
                    Text("Add Ingredients")
                }
            }.padding()
        }
        .environmentObject(recipesList)
        .environmentObject(aiList)
        .environmentObject(ingredients)
        .environmentObject(equipment)
        .environmentObject(steps)
    }
}
#if DEBUG
#Preview {
    IngredientsManagementView()
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(StepsList())
        .environmentObject(ARecipesList())
        .environmentObject(AnalyzedInstructionList())
}
#endif
