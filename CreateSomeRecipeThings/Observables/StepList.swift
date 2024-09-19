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
#if DEBUG
            print("Contents", contents)
#endif
            if contents.isEmpty {
#if DEBUG
                print("Contents Empty")
#endif
                steps = []
            } else {
                let fileUrl = getRecipesStepsDirUrl()
#if DEBUG
                print("Steps url: ", fileUrl)
#endif
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
#if DEBUG
                    print("Step url: ", url)
#endif
                    let astep = try JSONDecoder().decode(Step.self, from: try! Data(contentsOf: url))
                    steps.append(astep)
                }
            }
        } catch {
#if DEBUG
            print("not able to read steps")
#endif
            self.steps = []
        }
    }
    
    
    @MainActor
    
    func getCountOfSteps() -> Int {
        return steps.count
    }
    
    func saveStep(step: Step) {
//        let stepToSave = steps.first(where: { $0.number == step.number })!
        self.steps.append(step)
        let stepsDir = getRecipesStepsDirUrl()
        let stepFileUrl = stepsDir.appendingPathComponent(step.step.replacingOccurrences(of: " ", with: "_").appending("\(step.number)" + ".json"))
        do {
            try JSONEncoder().encode(step).write(to: stepFileUrl)
#if DEBUG
            print("Saved step: \(step)")
            print("Saved step to: \(stepFileUrl)")
#endif
        } catch {
            print("Error saving step: \(error)")
        }
    }
    
    func deleteStep(step: Step) {
        self.steps.removeAll(where: { $0.number == step.number })
        deleteStepInStorage(step: step)
    }
    
    fileprivate func deleteStepInStorage(step: Step) {
        let stepsDir = getRecipesStepsDirUrl()
        let stepFileUrl = stepsDir.appendingPathComponent(step.step.replacingOccurrences(of: " ", with: "_").appending("\(step.number)" + ".json"))
        do {
            let data = try Data(contentsOf: stepFileUrl)
            try data.write(to: stepFileUrl, options: .atomic)
            try FileManager.default.removeItem(at: stepFileUrl)
#if DEBUG
            print("Deleted step: \(step)")
            print("Deleted step from: \(stepFileUrl)")
#endif
        } catch {
            #if DEBUG
            print("Error deleting step: \(error)")
            #endif
        }
    }
}
