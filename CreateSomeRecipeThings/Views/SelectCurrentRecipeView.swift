//
//  SelectCurrentRecipeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/22/24.
//

import SwiftUI

struct SelectCurrentRecipeView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var userRecipes: UserRecipes
    
    @State var selectedRecipe: Arecipe?
    
    func deleteUserRecipe(at offsets: IndexSet) {
        userRecipes.userrecipes.remove(atOffsets: offsets)
        self.selectedRecipe = nil
    }
    
    var body: some View {
        VStack {
            Text("Select the current recipe")
                .font(.title)
            
            VStack {
                Text("No user recipes yet, create one!").disabled(userRecipes.userrecipes.count > 0)
                List {
                    ForEach(userRecipes.userrecipes, id: \.self) { userRecipe in
                        Text(userRecipe.title)
                            .onTapGesture {
                                selectedRecipe = userRecipe
                                userRecipes.addRecipe(userRecipe)
                                userRecipes.currentRecipe = userRecipe
#if DEBUG
                                print("Selected Recipe: \(userRecipe.title)")
#endif
                            }
                    }
                    .onDelete(perform: deleteUserRecipe)
                    .disabled(userRecipes.userrecipes.count == 0)
                }
                
                Text("Selected Recipe is: " +  (selectedRecipe?.title ?? "None"))
                    .disabled(selectedRecipe == nil)
            }
        }
    }
}

#Preview {
    SelectCurrentRecipeView()
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
