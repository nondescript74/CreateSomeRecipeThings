//
//  ARecipesManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct ARecipesManagementView: View {
    @StateObject var recipesList = ARecipesList()
    
    var body: some View {
        NavigationStack {
            VStack {
                RecipesView()
            }
            
            NavigationLink {
                AddARecipeView()
            } label: {
                Text("Add Recipe")
            }
            
        }.environmentObject(recipesList)
    }
}

#Preview {
    ARecipesManagementView().environmentObject(ARecipesList())
}
