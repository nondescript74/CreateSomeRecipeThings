//
//  ApplicationView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/16/24.
//

import SwiftUI

struct ApplicationView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var userRecipes: UserRecipes
    // MARK: - Properties
    fileprivate enum tabs: String {
        case create = "Create"
        case length = "Length"
        case display = "Show"
        case select = "Recipe"
        case ingredients = "Ingred"
        case equipment = "Equip"
        case delete = "Delete"
    }
    var body: some View {
        TabView {
            SelectCurrentRecipeView().tabItem {
                Image(uiImage: UIImage(systemName: "square.and.arrow.down")!)
                Text(tabs.select.rawValue)
            }
            
            DisplayStepsView().tabItem {
                Image(uiImage: UIImage(systemName: "book")!)
                Text(tabs.display.rawValue)
            }
            
            CreateStepView().tabItem {
                Image(uiImage: UIImage(systemName: "list.bullet")!)
                Text(tabs.create.rawValue)
            }
//            
//            ChooseIngredView().tabItem {
//                Image(uiImage: UIImage(systemName: "checklist.unchecked")!)
//                Text(tabs.ingredients.rawValue)
//            }
//            
//            ChooseEquipmentView().tabItem {
//                Image(uiImage: UIImage(systemName: "list.bullet.clipboard")!)
//                Text(tabs.equipment.rawValue)
//            }
            
            DeleteStepsView().tabItem {
                Image(uiImage: UIImage(systemName: "trash")!)
                Text(tabs.delete.rawValue)
            }
        }
        .environmentObject(stepList)
        .environmentObject(selectedIngredientsList)
        .environmentObject(selectedEquipmentList)
        .environmentObject(userRecipes)
        
    }
}

#Preview {
    ApplicationView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
