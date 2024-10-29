//
//  ApplicationView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/16/24.
//

import SwiftUI

struct ApplicationView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var stepsList: StepsList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var ingredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList

    // MARK: - Properties
    fileprivate enum tabs: String {
        case steps = "Steps"
        case ai = "Instructions"
        case recipes = "Recipes"
        case ingredients = "Ingredients"
        case equipment = "Equipment"
        case display = "Display"
    }
    
    fileprivate enum images: String {
        case steps = "square.and.arrow.up.circle.fill"
        case ai = "rectangle.portrait.and.arrow.right"
        case recipes = "square.and.arrow.up.on.square.fill"
        case ingredients = "tray.circle"
        case equipment = "rectangle.and.pencil.and.ellipsis"
        case display = "wand.and.rays.inverse"
    }
    var body: some View {
        TabView {
            ARecipesManagementView().tabItem {
                Image(uiImage: UIImage(systemName: images.recipes.rawValue)!)
                Text(tabs.recipes.rawValue)
            }
            
            AInstructionsManagementView().tabItem {
                Image(uiImage: UIImage(systemName: images.ai.rawValue)!)
                Text(tabs.ai.rawValue)
            }
            
            IngredientsManagementView().tabItem {
                Image(uiImage: UIImage(systemName: images.ingredients.rawValue)!)
                Text(tabs.ingredients.rawValue)
            }
        }
        .environmentObject(stepsList)
        .environmentObject(aiList)
        .environmentObject(recipesList)
        .environmentObject(ingredientsList)
        .environmentObject(selectedEquipmentList)
    }
}

#if DEBUG
#Preview {
    ApplicationView()
        .environmentObject(StepsList())
        .environmentObject(AnalyzedInstructionList())
        .environmentObject(ARecipesList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
}
#endif
