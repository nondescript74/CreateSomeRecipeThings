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
#if DEBUG
        print("Initialized: ", self.selectedEquipment)
#endif
    }
    
    
    @MainActor
    func addEquipment(_ equipment: Ent) {
        if self.selectedEquipment.contains(where: { $0.id == equipment.id }) { return }
        self.selectedEquipment.append(equipment)
#if DEBUG
        print("Added: ", equipment)
        print(self.selectedEquipment)
#endif
    }
    @MainActor
    func removeEquipment(_ equipment: Ent) {
        self.selectedEquipment.removeAll(where: { $0.id == equipment.id })
#if DEBUG
        print("Removed: ", equipment)
        print(self.selectedEquipment)
#endif
    }
}
