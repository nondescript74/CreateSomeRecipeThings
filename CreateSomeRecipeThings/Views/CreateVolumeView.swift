//
//  CreateVolumeView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/17/24.
//

import SwiftUI

struct CreateAmountView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    @State fileprivate var unit: String = "teaspoon"
    @State fileprivate var number: Double?
    
    let volumeUnits: [String] = ["teaspoon", "tablespoon", "cup", "pint", "quart", "gallon", "milliliter", "liter", "ounce", "pound", "gram", "kilogram"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    var body: some View {
        HStack {
            TextField("Enter amount", value: $number, formatter: formatter)
                .padding()
            Picker("Unit", selection: $unit) {
                ForEach(volumeUnits, id: \.self) { Text($0)
                }
            }
            .padding()
        }
        .environmentObject(stepList)
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
        
        
    }
}

#Preview {
    CreateAmountView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
