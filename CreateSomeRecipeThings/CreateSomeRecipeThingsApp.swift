//
//  CreateSomeRecipeThingsApp.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

@main
struct CreateSomeRecipeThingsApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationView()
                .environmentObject(SelectedIngredientsList())
                .environmentObject(StepList())
                .environmentObject(SelectedEquipmentList())
                .environmentObject(UserRecipes())
        }
    }
}
