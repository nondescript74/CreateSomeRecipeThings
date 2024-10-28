//
//  DisplayFilesView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 10/27/24.
//

import SwiftUI

struct DisplayFilesView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var stepsList: StepsList
    @EnvironmentObject var aiList: AnalyzedInstructionList
    @EnvironmentObject var recipesList: ARecipesList
    @EnvironmentObject var ingredientsList: SelectedIngredientsList
    @EnvironmentObject var equipmentList: SelectedEquipmentList

    // MARK: - Properties
    fileprivate enum tabs: String {
        case steps = "Steps"
        case ai = "Instruc"
        case recipes = "Recipes"
        case ingredients = "Ingred"
        case equipment = "Equip"
    }
    
    fileprivate enum images: String {
        case steps = "square.and.arrow.up.circle.fill"
        case ai = "rectangle.portrait.and.arrow.right"
        case recipes = "square.and.arrow.up.on.square.fill"
        case ingredients = "tray.circle"
        case equipment = "photo.artframe.circle"
    }
    
    var body: some View {
        TabView {
            DisplayARecipesShippedView().tabItem {
                Image(uiImage: UIImage(systemName: images.recipes.rawValue)!)
                Text(tabs.recipes.rawValue)
            }
            
            DisplayIngredientNamesView().tabItem {
                Image(uiImage: UIImage(systemName: images.ingredients.rawValue)!)
                Text(tabs.ingredients.rawValue)
            }
        }
        .environmentObject(stepsList)
        .environmentObject(aiList)
        .environmentObject(recipesList)
        .environmentObject(ingredientsList)
        .environmentObject(equipmentList)
    }
}

#Preview {
    DisplayFilesView()
        .environmentObject(StepsList())
        .environmentObject(AnalyzedInstructionList())
        .environmentObject(ARecipesList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(SelectedEquipmentList())
}
