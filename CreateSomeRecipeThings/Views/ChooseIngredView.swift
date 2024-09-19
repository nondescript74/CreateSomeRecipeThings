//
//  ChooseIngredView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI
import UIKit

struct ChooseIngredView: View {
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    @State private var searchText: String = ""
    @State private var filteredIngredients: [Ingredient] = []
    @State private var displayedIngredient: Ingredient?
    @State private var selection = Set<Ingredient>()
    @State fileprivate var unit: String = "teaspoon"
    @State fileprivate var number: Int?
    
    
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
#if DEBUG
        print("Filtered Ingredients: \(filteredIngredients)")
        print("Search Text: \(searchText)")
#endif
    }
    
//    private func remove() {
//        if selection.isEmpty { return }
//        for eachSel in selection {
//            if selectedIngredientsList.selectedIngredients.contains(eachSel) {
//#if DEBUG
//                print("Removing: \(eachSel)")
//#endif
//                selectedIngredientsList.removeIngredient(eachSel)
//#if DEBUG
//                print("Removed: \(eachSel)")
//#endif
//            } else {
//#if DEBUG
//                print("Not Removing: \(eachSel)")
//                print(eachSel.name, eachSel.id)
//                print(selectedIngredientsList.selectedIngredients)
//#endif
//            }
//        }
//    }
    
    private func remove() {
        if selection.isEmpty { return }
#if DEBUG
        print("Removing: \(selection)")
#endif
        for eachSel in selection {
            selectedIngredientsList.removeIngredient(eachSel)
        }
    }
    
    private func add() {
        if selection.isEmpty { return }
        for eachSel in selection {

                let createIngredientWithAmount = Ingredient(id: eachSel.id, name: eachSel.name, localizedName: eachSel.localizedName, image: eachSel.image, amount: Length(number: number ?? 0, unit: unit))
                selectedIngredientsList.addIngredient(createIngredientWithAmount)


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
            HStack {
                TextField("Enter amount", value: $number, formatter: formatter)
                    .padding()
                Picker("Unit", selection: $unit) {
                    ForEach(volumeUnits, id: \.self) { Text($0)
                    }
                }
                .padding()
            }
            List(filteredIngredients, id: \.self, selection: $selection) { ent in
                Text(ent.name)
            }
            
            HStack {
                Button(action: add) {
                    Text("Add")
                        .padding()
                }.disabled(selection.count == 0 || selection.count > 1)
                
                Button(action: remove) {
                    Text("Remove")
                        .padding()
                }.disabled(selection.count == 0)
            }

            List(selectedIngredientsList.selectedIngredients, id: \.self) { ingred in
                Text(ingred.name)
            }
            
            .navigationTitle("Choose Ingredients")
//            .toolbar {
//                EditButton()
//            }
        }
        .environmentObject(stepList)
        .environmentObject(selectedEquipmentList)
        .environmentObject(selectedIngredientsList)
        
    }
    
}

#Preview {
    ChooseIngredView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
