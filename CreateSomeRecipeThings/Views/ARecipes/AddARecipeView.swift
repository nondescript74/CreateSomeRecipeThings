//
//  AddARecipeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AddARecipeView: View {
    @EnvironmentObject var aRecipeList: ARecipesList
    @State private var recipeName: String = "This should be the recipe name"
    @State private var recipeSummary: String = "This should be the summary"

    var body: some View {
        Text("Create a new recipe")
            .font(.title)
        
        VStack {
            TextField("Recipe Name", text: $recipeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        VStack {
            TextField("Add a step", text: $recipeSummary)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        
        Button("Add") {
            aRecipeList.addRecipe(arecipe: Arecipe(extendedIngredients: [], title: recipeName, summary: recipeSummary, cuisines: [], dishTypes: [], diets: [], occasions: [], analyzedInstructions: [], recipeUUID: UUID()))
        }
        
        Button("Remove") {
            aRecipeList.removeRecipe(arecipe: aRecipeList.currentRecipe)    
        }
    }
}

#Preview {
    AddARecipeView().environmentObject(ARecipesList())
}
