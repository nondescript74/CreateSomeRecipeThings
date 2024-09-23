//
//  CreateLengthView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

struct CreateLengthView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var userRecipes: UserRecipes
    
    @State fileprivate var unit: String = "centimeter"
    @State fileprivate var number: Double = 1.00
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    var body: some View {
        HStack {
            TextField("Enter amount", value: $number, formatter: formatter)
            Picker("Unit", selection: $unit) {
                ForEach(fluidUnits, id: \.self) { Text($0)
                }
            }
        }
        
        .environmentObject(stepList)
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
    }
}

#Preview {
    CreateLengthView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
        .environmentObject(UserRecipes())
}
