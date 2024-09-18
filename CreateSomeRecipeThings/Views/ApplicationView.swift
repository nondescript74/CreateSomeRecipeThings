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
    
    // MARK: - Properties
    fileprivate enum tabs: String {
        case create = "Create"
        case length = "Length"
        case display = "Show"
        case ingredients = "Ingred"
        case equipment = "Equip"
    }
    var body: some View {
        TabView {
            DisplayStepsView().tabItem {
                Image(uiImage: UIImage(systemName: "book")!)
                Text(tabs.display.rawValue)
            }
            
            CreateStepView(ruuid: UUID()).tabItem {
                Image(uiImage: UIImage(systemName: "list.bullet")!)
                Text(tabs.create.rawValue)
            }
            
            ChooseIngredView().tabItem {
                Image(uiImage: UIImage(systemName: "checklist.unchecked")!)
                Text(tabs.ingredients.rawValue)
            }
            
            ChooseEquipmentView().tabItem {
                Image(uiImage: UIImage(systemName: "list.bullet.clipboard")!)
                Text(tabs.equipment.rawValue)
            }
        }
        .environmentObject(stepList)
        .environmentObject(selectedIngredientsList)
        .environmentObject(selectedEquipmentList)
        
    }
}

#Preview {
    ApplicationView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
