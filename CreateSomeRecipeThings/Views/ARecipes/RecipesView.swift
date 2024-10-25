//
//  RecipesView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipesList: ARecipesList
    var body: some View {
        VStack {
            Text("There are " + recipesList.userRecipes.count.description + " recipes")
                .font(.title)
            ForEach(recipesList.userRecipes, id: \.self.recipeUUID) { arecipe in
                Text(arecipe.title)
            }
        }
    }
}

#Preview {
    RecipesView().environmentObject(ARecipesList())
}
