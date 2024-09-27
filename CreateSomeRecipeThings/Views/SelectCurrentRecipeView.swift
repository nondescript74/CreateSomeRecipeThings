//
//  SelectCurrentRecipeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/22/24.
//

import SwiftUI

struct SelectCurrentRecipeView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    // MARK: - State
//    @State private var selectedRecipe: Arecipe
    @State private var searchText: String = ""
    
    
    init() {
#if DEBUG
        print("Initializing SelectCurrentRecipeView")
#endif
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    func deleteUserRecipe(at offsets: IndexSet) {
        userData.userRecipes.userrecipes.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack {
            Text("Recipe management")
                .font(.title)
            
            VStack {
                Text("These are the recipes you've created.").font(.headline).padding()
                List {
                    ForEach(userData.userRecipes.userrecipes, id: \.self) { userRecipe in
                        Text(userRecipe.title)
                            .onTapGesture {
                                userData.userRecipes.currentRecipe = userRecipe
//                                selectedRecipe = userRecipe
//#if DEBUG
//                                print("Selected Recipe, current recipe: \(userData.userRecipes.currentRecipe.title)")
//#endif
                            }
                    }
                    .onDelete(perform: deleteUserRecipe)
                    .disabled(userData.userRecipes.userrecipes.count == 0)
                }
                
            }.background(Color.blue.opacity(0.1))
            .padding()
            
            VStack {
                Text("Update Recipe and save").font(.headline)
//                Text("Selected recipe: " + selectedRecipe.title)
                Button ("Update + Save") {
                    userData.userRecipes.currentRecipe.analyzedInstructions = userData.analyzedInstructions.instructions
                    userData.userRecipes.saveRecipe()
                    userData.userRecipes = .init()
                }
                
            }
            
            
            VStack {
                Text("Create a new recipe").font(.headline)
                    .padding()
                TextField("Recipe Title", text: $searchText)
                Button("Create + Save") {
                     let selectedRecipe = Arecipe(extendedIngredients: [], title: searchText, summary: "Creating a new recipe", cuisines: [], dishTypes: [], diets: [], occasions: [], analyzedInstructions: [], recipeUUID: UUID())
                    userData.userRecipes.currentRecipe = selectedRecipe
#if DEBUG
                    print("Creating Recipe with title: \(searchText)")
                    print("Saving Recipe: \(selectedRecipe.title)")
#endif
                    userData.userRecipes.saveRecipe()
                    userData.userRecipes = .init()
                    
                }.disabled(searchText.isEmpty)
            }.background(Color.gray.opacity(0.1))
            .padding()

        }
    }
}

#Preview {
    SelectCurrentRecipeView()
        .environmentObject(UserData())
}
