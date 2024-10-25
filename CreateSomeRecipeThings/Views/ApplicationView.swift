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

    // MARK: - Properties
    fileprivate enum tabs: String {
        case steps = "Steps"
        case ai = "Instructions"
        case recipes = "Recipes"
    }
    var body: some View {
        TabView {
            ARecipesManagementView().tabItem {
                Image(uiImage: UIImage(systemName: "square.and.arrow.up.circle.fill")!)
                Text(tabs.recipes.rawValue)
            }
            StepsManagementView().tabItem {
                Image(uiImage: UIImage(systemName: "square.and.arrow.down")!)
                Text(tabs.steps.rawValue)
            }
            AInstructionsManagementView().tabItem {
                Image(uiImage: UIImage(systemName: "square.and.arrow.up.circle")!)
                Text(tabs.ai.rawValue)
            }
            .environmentObject(stepsList)
            .environmentObject(aiList)
            .environmentObject(recipesList)
        }
    }
}

#Preview {
    ApplicationView()
        .environmentObject(StepsList())
        .environmentObject(AnalyzedInstructionList())
        .environmentObject(ARecipesList())
}
