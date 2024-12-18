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
                .environmentObject(StepsList())
                .environmentObject(AnalyzedInstructionList())
                .environmentObject(ARecipesList())
                .environmentObject(SelectedIngredientsList())
                .environmentObject(SelectedEquipmentList())
        }
    }
}
