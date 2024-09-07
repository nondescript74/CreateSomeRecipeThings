//
//  CreateSomethingView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import SwiftUI

struct CreateSomethingView: View {
    
    init (someenum: SomeEnum, payload: Any) {
        self.someVariable = someenum
        self.somePayload = payload
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
    
    var body: some View {
        Text("Hello, Zahirudeen!")
        
        switch someVariable {
        case .metric:
            if somePayload is Length {
                Text("Length")
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
    CreateSomethingView(someenum: .metric, payload: Step(number: 1, step: "First", ingredients: [Ent](), equipment: [Ent](), length: nil))
    CreateSomethingView(someenum: .metric, payload: Length(number: 1, unit: "meter"))
}
