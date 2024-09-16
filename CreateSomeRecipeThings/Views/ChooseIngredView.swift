//
//  ChooseIngredView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct ChooseIngredView: View {
    @ObservedObject var selectedIngredientsList: SelectedIngredientsList = SelectedIngredientsList.init()
    @State private var searchText: String = ""
    @State private var filteredIngredients: [Ingredient] = []
    @State private var displayedIngredient: Ingredient?
    @State private var selection = Set<Ingredient>()
    
    
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
        print("Filtered Ingredients: \(filteredIngredients)")
        print("Search Text: \(searchText)")
    }
    
    private func remove() {
        if selection.isEmpty { return }
        for eachSel in selection {
            if selectedIngredientsList.selectedIngredients.contains(eachSel) {
                selectedIngredientsList.removeIngredient(eachSel)
            }
        }
    }
    
    private func add() {
        if selection.isEmpty { return }
        for eachSel in selection {
            if !selectedIngredientsList.selectedIngredients.contains(eachSel) {
                selectedIngredientsList.addIngredient(eachSel)}
        }
    }
    
    
    
    var body: some View {
        
        NavigationStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .border(Color.black)
                    .padding()
                
                Button(action: search) {
                    Image(systemName: "magnifyingglass")
                }
                .padding(.trailing)
            }
            
            List(filteredIngredients, id: \.self, selection: $selection) { ent in
                Text(ent.name)
            }
            
            HStack {
                Button(action: add) {
                    Text("Add")
                        .padding()
                }.disabled(selection.count == 0)
                
                Button(action: remove) {
                    Text("Remove")
                        .padding()
                }.disabled(selection.count == 0)
            }
            
            List(selectedIngredientsList.selectedIngredients, id: \.self) { ingred in
                Text(ingred.name)
            }
            
            .navigationTitle("Choose Ingredients")
            .toolbar {
                EditButton()
            }
        }
        
    }
    
}

#Preview {
    ChooseIngredView()
}