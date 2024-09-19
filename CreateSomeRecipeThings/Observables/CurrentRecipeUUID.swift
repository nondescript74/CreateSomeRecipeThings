//
//  CurrentRecipeUUID.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/18/24.
//

import Foundation

class CurrentRecipeUUID: ObservableObject {
    
    // MARK: - Publisher
    @Published var uuid: UUID
    
    init() {
        self.uuid = UUID()
    }
}
