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
        self.selectedRecipe = nil
    }
    
    private func saveRecipe() {
        guard let selectedRecipe else { return }
        userData.userRecipes.addRecipe(selectedRecipe)
        userData.userRecipes.currentRecipe = selectedRecipe
        userData.userRecipes.saveRecipe()
#if DEBUG
        print("Selected Recipe: \(selectedRecipe.title)")
#endif
    }
    
    var body: some View {
        VStack {
            Text("Select the current recipe")
                .font(.title)
            
            VStack {
                Text("No user recipes yet, create one!").disabled(userData.userRecipes.userrecipes.count > 0)
                
                List {
                    ForEach(userData.userRecipes.userrecipes, id: \.self) { userRecipe in
                        Text(userRecipe.title)
                            .onTapGesture {
                                selectedRecipe = userRecipe
                                userData.userRecipes.addRecipe(userRecipe)
                                userData.userRecipes.currentRecipe = userRecipe
#if DEBUG
                                print("Selected Recipe: \(userRecipe.title)")
#endif
                            }
                    }
                    .onDelete(perform: deleteUserRecipe)
                    .disabled(userData.userRecipes.userrecipes.count == 0)
                }
            }.background(Color.blue.opacity(0.1))
            .padding()
            
            
            VStack {
                Text("Create a new recipe")
                    .padding()
                TextField("Recipe Title", text: $searchText)
                Button("Create Recipe") {
                    selectedRecipe = Arecipe(extendedIngredients: [], title: searchText, summary: "Creating a new recipe", cuisines: [], dishTypes: [], diets: [], occasions: [], analyzedInstructions: [], recipeUUID: UUID())
#if DEBUG
                    print("Creating Recipe with title: \(searchText)")
#endif
                }
                
                Button("Save") {
                    
#if DEBUG
                    print("Saving Recipe: \(selectedRecipe?.title ?? "None")")
#endif
                    saveRecipe()
                }
            }.background(Color.gray.opacity(0.1))
            .padding()
            
            VStack {
                
                Text("Selected Recipe is: " +  (selectedRecipe?.title ?? "None"))
                    .disabled(selectedRecipe == nil)
                    .padding()
                
                
            }.background(Color.cyan.opacity(0.1))
            .padding()
        }
    }
}

#Preview {
    SelectCurrentRecipeView()
        .environmentObject(UserData())
}
