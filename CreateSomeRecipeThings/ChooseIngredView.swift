//
//  ChooseIngredView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct ChooseIngredView: View {
    @ObservedObject var selectedIngredientsList = SelectedIngredientsList.init()
    @State private var searchText: String = ""
    @State private var filteredIngredients: [Ingredient] = []
    @State private var displayedIngredient: Ingredient?

    
    init() {
          UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    private let ingred_list = Bundle.main.url(forResource:"ingredients_list", withExtension: "json")
    
    private func createJSON() -> [Ingredient] {
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
    
    private func search() {
        let ingredients = createJSON()
        filteredIngredients = ingredients.filter({$0.name.contains(searchText.lowercased())})
    }
    
    private func add() {
        // expects the first value only
        if filteredIngredients.isEmpty { return }
        if filteredIngredients.count > 1 { return }
        if selectedIngredientsList.selectedIngredients.contains(filteredIngredients[0]) { return }
        selectedIngredientsList.addIngredient(filteredIngredients[0])
        print(selectedIngredientsList.selectedIngredients)
    }
    
    private func remove() {
        if selectedIngredientsList.selectedIngredients.isEmpty { return }
        if filteredIngredients.count > 1 { return }
        if !selectedIngredientsList.selectedIngredients.contains(filteredIngredients[0]) { return }
        selectedIngredientsList.removeIngredient(filteredIngredients[0])
        print(selectedIngredientsList.selectedIngredients)
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .border(Color.black)
                    .padding()
                
                Button(action: search) {
                    Image(systemName: "magnifyingglass")
                }
            }
            
            List {
                ForEach(selectedIngredientsList.selectedIngredients, id: \.self) {
                    Text($0.name)
                }
            }
            
            Picker("Select", selection: $displayedIngredient) {
                ForEach(filteredIngredients, id: \.self) {
                    Text($0.name)
                }
            }.pickerStyle(.wheel)
            
            
            HStack {
                Button(action: add) {
                    Text("Add")
                        .padding()
                }.disabled(filteredIngredients.count == 0 || filteredIngredients.count > 1)
                
                Button(action: remove) {
                    Text("Remove")
                        .padding()
                }.disabled(filteredIngredients.count == 0 || filteredIngredients.count > 1)
            }
            
        }
    }
}

#Preview {
    ChooseIngredView()
}
