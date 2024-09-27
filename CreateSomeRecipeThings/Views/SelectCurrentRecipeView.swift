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
    @State private var selectedRecipe: Arecipe?
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
    
    private func saveRecipe(arecipe: Arecipe) {
        userData.userRecipes.addRecipe(arecipe)
        userData.userRecipes.currentRecipe = arecipe
        userData.userRecipes.saveRecipe()
        userData.userRecipes = .init()
    }
    
    var body: some View {
        VStack {
            Text("Select the current recipe")
                .font(.title)
            
            VStack {
                List {
                    ForEach(userData.userRecipes.userrecipes, id: \.self) { userRecipe in
                        Text(userRecipe.title)
                            .onTapGesture {
//                                selectedRecipe = userRecipe
                                userData.userRecipes.currentRecipe = userRecipe
                                selectedRecipe = userRecipe
#if DEBUG
                                print("Selected Recipe: \(userData.userRecipes.currentRecipe.title)")
#endif
                            }
                            .padding()
                    }
                    .onDelete(perform: deleteUserRecipe)
                    .disabled(userData.userRecipes.userrecipes.count == 0)
                }
                
                Text(selectedRecipe?.title ?? "No Recipe Selected")
                
            }.background(Color.blue.opacity(0.1))
            .padding()
            
            
            VStack {
                Text("Create a new recipe")
                    .padding()
                TextField("Recipe Title", text: $searchText)
                Button("Create Recipe") {
                     let selectedRecipe = Arecipe(extendedIngredients: [], title: searchText, summary: "Creating a new recipe", cuisines: [], dishTypes: [], diets: [], occasions: [], analyzedInstructions: [], recipeUUID: UUID())
#if DEBUG
                    print("Creating Recipe with title: \(searchText)")
                    print("Saving Recipe: \(selectedRecipe.title)")
#endif
                    saveRecipe(arecipe: selectedRecipe)
                }.border(.bar, width: 2)
            }.background(Color.gray.opacity(0.1))
            .padding()

        }
    }
}

#Preview {
    SelectCurrentRecipeView()
        .environmentObject(UserData())
}
