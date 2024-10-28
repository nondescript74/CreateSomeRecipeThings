//
//  IngredientsManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/26/24.
//

import SwiftUI

struct IngredientsManagementView: View {
    @EnvironmentObject var ingredients: SelectedIngredientsList
    
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
    }
}
#if DEBUG
#Preview {
    IngredientsManagementView()
        .environmentObject(SelectedIngredientsList())
}
#endif
