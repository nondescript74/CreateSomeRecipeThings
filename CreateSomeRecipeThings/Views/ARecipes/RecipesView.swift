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
                .font(.subheadline).padding()
            ForEach(recipesList.userRecipes, id: \.self.recipeUUID) { arecipe in
                Text(arecipe.title).onTapGesture {
                    recipesList.setCurrentRecipe(arecipe: arecipe)
#if DEBUG
                    print("Recipe tapped, current is now: \(recipesList.currentRecipe.title)")
#endif
                }
                ForEach(arecipe.analyzedInstructions, id: \.self) { ai in
                    Text(ai!.name)
                }.disabled(arecipe.analyzedInstructions.isEmpty)
            }.disabled(recipesList.userRecipes.isEmpty)
        }
    }
}

#Preview {
    RecipesView().environmentObject(ARecipesList())
}
