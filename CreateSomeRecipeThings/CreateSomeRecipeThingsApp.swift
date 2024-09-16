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
//            ChooseIngredView()
//            ChooseEquipmentView()
            CreateStepView(ruuid: UUID())
                .environmentObject(SelectedIngredientsList())
                .environmentObject(StepList())
                .environmentObject(SelectedEquipmentList())
        }
    }
}
