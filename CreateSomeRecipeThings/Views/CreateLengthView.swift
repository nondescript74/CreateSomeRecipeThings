//
//  CreateLengthView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

struct CreateLengthView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    
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
        
        .environmentObject(userData)
    }
}

#Preview {
    CreateLengthView()
        .environmentObject(UserData())
}
