//
//  SelectedEquipmentList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/12/24.
//

import Foundation


class SelectedEquipmentList: ObservableObject {
    
    // MARK: - Publisher
    @Published var selectedEquipment: [Ent]
    
    init() {
        self.selectedEquipment = []
    }
    
    
    @MainActor
    func addEquipment(_ equipment: Ent) {
        selectedEquipment.append(equipment)
    }
    
    func removeEquipment(_ equipment: Ent) {
        selectedEquipment.removeAll(where: { $0.id == equipment.id })   
    }
}
