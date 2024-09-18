//
//  StepList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/11/24.
//

import Foundation
import SwiftUI

class StepList: ObservableObject {
    
    @EnvironmentObject var selectedEquipmentList: SelectedEquipmentList
    @EnvironmentObject var selectedIngredientsList: SelectedIngredientsList
    @EnvironmentObject var stepList: StepList
    
    // MARK: - Publisher
    @Published var steps: [Step] = []
    
    init() {
        do  {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesStepsDirUrl().path)
            print("Contents", contents)
            if contents.isEmpty {
                print("Contents Empty")
                steps = []
            } else {
                let fileUrl = getRecipesStepsDirUrl()
                print("Steps url: ", fileUrl)
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
                    print("Step url: ", url)
                    let astep = try JSONDecoder().decode(Step.self, from: try! Data(contentsOf: url))
                    steps.append(astep)
                }
            }
        } catch {
            print("not able to read steps")
            self.steps = []
        }
    }
    
    
    @MainActor

    func addStep(text: String) {
        if self.steps.contains(where: { $0.step == text }) {
            print("Step already exists")
            return
        }
        print("Adding step: \(text)")
//        print("Ingredients: ", selectedIngredientsList.selectedIngredients)
        let step = Step(number: steps.count + 1, step: text, ingredients: [], equipment: [] , length: .none)
        self.steps.append (step)
        saveStep(step: step)
    }
    
    private func saveStep(step: Step) {
        let stepToSave = steps.first(where: { $0.number == step.number })!
        let stepsDir = getRecipesStepsDirUrl()
        let stepFileUrl = stepsDir.appendingPathComponent(step.step.replacingOccurrences(of: " ", with: "_").appending("\(step.number)" + ".json"))
        do {
            try JSONEncoder().encode(stepToSave).write(to: stepFileUrl)
            print("Saved step: \(stepToSave)")
            print("Saved step to: \(stepFileUrl)")
        } catch {
            print("Error saving step: \(error)")
        }
    }
    
    
}
