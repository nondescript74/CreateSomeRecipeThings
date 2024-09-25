//
//  ChooseEquipmentView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/12/24.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
struct ChooseEquipmentView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var userData: UserData
    
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
#if DEBUG
            print("Error: \(error)")
#endif
            return []
        }
    }
    
    private func search() {
        let equipment = createJSON()
        filteredEquipment = equipment.filter({$0.name.contains(searchText.lowercased())})
#if DEBUG
        print(filteredEquipment)
#endif
    }
    
    private func remove() {
        if selection.isEmpty { return }
#if DEBUG
        print(userData.selectedEquipList.selectedEquipment)
#endif
        for eachSel in selection {
            if userData.selectedEquipList.selectedEquipment.contains(eachSel) {
                userData.selectedEquipList.selectedEquipment.remove(at: userData.selectedEquipList.selectedEquipment.firstIndex(of: eachSel)!)
#if DEBUG
               print("Removed: \(eachSel)")
#endif
            }
        }
    }
    
    private func add() {
        if selection.isEmpty { return }
        for eachSel in selection {
            if !userData.selectedEquipList.selectedEquipment.contains(eachSel) {
                userData.selectedEquipList.addEquipment(eachSel)
#if DEBUG
                print("Added: ", userData.selectedEquipList.selectedEquipment.last!)
#endif
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
            
            List(userData.selectedEquipList.selectedEquipment, id: \.self) { ent in
                Text(ent.name)
            }
            
            .navigationTitle("Choose Equipment")
        }
        .environmentObject(userData)
    }
}

#Preview {
    ChooseEquipmentView()
        .environmentObject(UserData())
}
