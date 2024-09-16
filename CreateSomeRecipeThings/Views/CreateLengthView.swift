//
//  CreateLengthView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

struct CreateLengthView: View {
    
    @State fileprivate var unit: String = "centimeter"
    @State fileprivate var number: Double = 1.00
    fileprivate let lengthUnits: [String] = ["centimeter", "meter", "inch", "foot"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        return formatter
    }()
    
    var body: some View {
            HStack {
                Picker("Unit", selection: $unit) {
                    ForEach(lengthUnits, id: \.self) { Text($0)
                    }
                }
                
                TextField("Enter amount", value: $number, formatter: formatter)
            }
    }
}

#Preview {
    CreateLengthView()
}
