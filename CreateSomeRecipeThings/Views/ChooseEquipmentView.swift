//
//  ChooseEquipmentView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/12/24.
//

import SwiftUI

struct ChooseEquipmentView: View {
    
    // MARK: - Environment Variables
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    @State private var searchText: String = ""
    @State private var filteredEquipment: [Ent] = []
    @State private var displayedEquipment: Ent?
    @State private var selection = Set<Ent>()
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    private let equip_list = Bundle.main.url(forResource: "equipment_list", withExtension: "json")!
    
    private func createJSON() -> [Ent] {
        do {
            let data = try Data(contentsOf: equip_list)
            let decoder = JSONDecoder()
            return try decoder.decode([Ent].self, from: data)
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    private func search() {
        let equipment = createJSON()
        filteredEquipment = equipment.filter({$0.name.contains(searchText.lowercased())})
        print(filteredEquipment)
    }
    
    private func remove() {
        if selection.isEmpty { return }
        for eachSel in selection {
            if selectedEquipmentList.selectedEquipment.contains(eachSel) {
                selectedEquipmentList.selectedEquipment.remove(at: selectedEquipmentList.selectedEquipment.firstIndex(of: eachSel)!)
                print("Removed: \(eachSel)")
            }
        }
    }
    
    private func add() {
        if selection.isEmpty { return }
        for eachSel in selection {
            if !selectedEquipmentList.selectedEquipment.contains(eachSel) {
                selectedEquipmentList.addEquipment(eachSel)
                print("Added: ", selectedEquipmentList.selectedEquipment.last!)
            }
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
            
            List(filteredEquipment, id: \.self, selection: $selection) { ent in
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
            
            List(selectedEquipmentList.selectedEquipment, id: \.self) { ent in
                Text(ent.name)
            }
            
            .navigationTitle("Choose Equipment")
        }
        
    }
}

#Preview {
    ChooseEquipmentView()
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
