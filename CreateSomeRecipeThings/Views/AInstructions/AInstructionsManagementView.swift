//
//  AInstructionsManagementView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

struct AInstructionsManagementView: View {
    @StateObject var aiList = AnalyzedInstructionList()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    AddAInstructionView()
                } label: {
                    Text("Add Instruction")
                }
                
                NavigationLink {
                    AInstructionsView()
                } label: {
                    Text("Show Instructions")
                }.disabled(aiList.instructions.isEmpty)
            }
            .padding()
        }.environmentObject(aiList)
    }
}

#Preview {
    AInstructionsManagementView().environmentObject(AnalyzedInstructionList())
}
