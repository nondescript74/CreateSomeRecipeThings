//
//  ChooseIngredView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct ChooseIngredView: View {
    
    @State fileprivate var ingredient: Ingredient
    @State private var searchIsActive = false
    
    init() {
        _ingredient = .init(initialValue: Ingredient(id: 2019, name: "fenugreek seeds"))
    }
    
    let ingred_list = Bundle.main.url(forResource:"ingredients_list", withExtension: "json")
    
    func createJSON() -> [Ingredient] {
        guard let url = ingred_list else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Ingredient].self, from: data)
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    func addRandom() {
        ingredient = createJSON().randomElement()!
        print(ingredient)
    }
    

    
    
    var body: some View {
        Text(ingredient.name + " " + ingredient.id.description)
            
        HStack {
            Picker("Unit", selection: $ingredient) {
                ForEach(createJSON(), id: \.self) {
                    Text($0.name)
                }
            }.pickerStyle(.wheel)
            
            Button(action: addRandom) {
                Text("Add Random")
            }.padding()
            
        }
    }
}

#Preview {
    ChooseIngredView()
}
