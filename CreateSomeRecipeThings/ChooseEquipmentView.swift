//
//  ChooseEquipmentView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/12/24.
//

import SwiftUI

struct ChooseEquipmentView: View {
    
    @ObservedObject var selectedEquipment = SelectedEquipmentList.init()
    @State private var searchText: String = ""
    @State private var filteredEquipment: [Ent] = []
    @State private var displayedEquipment: Ent?
    
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
    }
    
    private func addEquipment() {
        if filteredEquipment.isEmpty { return }
        if filteredEquipment.count > 1 { return }
        let equipment = filteredEquipment.first!
        if self.selectedEquipment.selectedEquipment.contains(equipment) { return }
        selectedEquipment.addEquipment(equipment)
        print(selectedEquipment.selectedEquipment)
    }
    
    private func removeEquipment() {
        if filteredEquipment.isEmpty { return }
        if filteredEquipment.count > 1 { return }
        if selectedEquipment.selectedEquipment.contains(filteredEquipment.first!) { return }
        selectedEquipment.removeEquipment(filteredEquipment.first!)
        print(selectedEquipment.selectedEquipment)
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
                ForEach(selectedEquipment.selectedEquipment, id: \.self) {
                    Text($0.name)
                }
            }
            
            Picker("Select", selection: $displayedEquipment) {
                ForEach(filteredEquipment, id: \.self) {
                    Text($0.name)
                }
            }.pickerStyle(.wheel)
            
            
            HStack {
                Button(action: addEquipment) {
                    Text("Add")
                        .padding()
                }.disabled(filteredEquipment.count == 0 || filteredEquipment.count > 1)
                
                Button(action: removeEquipment) {
                    Text("Remove")
                        .padding()
                }.disabled(filteredEquipment.count == 0 || filteredEquipment.count > 1)
            }
            
        }
    }
}

#Preview {
    ChooseEquipmentView()
}
