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
    @State var selectedRecipe: Arecipe?
    
    
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
                
                Text("Selected Recipe is: " +  (selectedRecipe?.title ?? "None"))
                    .disabled(selectedRecipe == nil)
                    .padding()
                Button("Save") {
                    
#if DEBUG
                    print("Saving Recipe: \(selectedRecipe?.title ?? "None")")
#endif
                    saveRecipe()
                }
            }
        }
    }
}

#Preview {
    SelectCurrentRecipeView()
        .environmentObject(UserData())
}
