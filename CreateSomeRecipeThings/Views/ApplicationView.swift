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

    // MARK: - Properties
    fileprivate enum tabs: String {
        case steps = "Steps"
        case ai = "AI"
        case picture = "Pic"
    }
    var body: some View {
        TabView {
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
        }
    }
}

#Preview {
    ApplicationView()
        .environmentObject(StepsList())
        .environmentObject(AnalyzedInstructionList())
}
