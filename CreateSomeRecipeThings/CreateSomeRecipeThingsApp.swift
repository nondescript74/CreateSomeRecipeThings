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
            CreateSomethingView(someenum: .metric, recipeuuid: UUID(), payload: Length(number: 100, unit: "milliliters"))
        }
    }
}
