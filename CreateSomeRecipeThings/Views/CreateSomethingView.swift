//
//  CreateSomethingView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

struct CreateSomethingView: View {
    
    // MARK: - Environment Variables
    @EnvironmentObject var stepList: StepList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    
    init (someenum: SomeEnum, recipeuuid: UUID, payload: Any) {
        self.someVariable = someenum
        self.somePayload = payload
        self.myrecipeUUID = recipeuuid
    }
    
    init (someenum: SomeEnum, recipeuuid: UUID) {
        self.someVariable = someenum
        self.myrecipeUUID = recipeuuid
    }
    
    enum SomeEnum {
        case metric
        case measures
        case consistency
        case extendedIngredient
        case length
        case ent
        case step
        case analyzedInstruction
        case arecipe
    }
    
    fileprivate var someVariable: SomeEnum = .metric
    fileprivate var somePayload: Any = Length(number: 1, unit: "meter")
    fileprivate var myrecipeUUID: UUID
    

    
    fileprivate func someFunction() {
        //get any other things saved by the user related to what is being created
        
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Text("Create a recipe parameter")
            .font(.title)
        Text(self.myrecipeUUID.uuidString)
            .font(.subheadline)
            
        switch someVariable {
        case .metric:
            if somePayload is Length {
                CreateLengthView()
            } else {Text("Not a Length")}
        case .measures:
            if somePayload is Measures {
                Text("Measures")
            } else {Text("Not a Measures")}
        case .consistency:
            if somePayload is Consistency {
                Text("Consistency")
            } else {Text("Not a Consistency")}
        case .extendedIngredient:
            if somePayload is ExtendedIngredient {
                Text("ExtendedIngredient")
            }  else {Text("Not a ExtendedIngredient")}
        case .length:
            if somePayload is Length {
                Text("Length")
            } else {Text("Not a Length")}
        case .ent:
            if somePayload is Ent {
                Text("Ent")
            } else {Text("Not a Ent")}
        case .step:
            if somePayload is Step {
                Text("Step")
            } else {Text("Not a Step")}
        case .analyzedInstruction:
            if somePayload is AnalyzedInstruction {
                Text("AnalyzedInstruction")
            } else {Text("Not a AnalyzedInstruction")}
        case .arecipe:
            if somePayload is Arecipe {
                Text("Arecipe")
            } else {Text("Not a Arecipe")}
        }
    }
}

#Preview {
    // create the preview with correct payload
    CreateSomethingView(someenum: .metric, recipeuuid: UUID(), payload: Length(number: 1, unit: "centimeter"))
        .environmentObject(SelectedEquipmentList())
        .environmentObject(SelectedIngredientsList())
        .environmentObject(StepList())
}
