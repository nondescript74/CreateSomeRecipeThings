//
//  StepsList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import Foundation

class StepsList: ObservableObject {
    
    // MARK: - Publisher
    @Published var steps: [Step] = [Step]()
        
    init() {
        do  {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesStepsDirUrl().path)
            if contents.isEmpty {
#if DEBUG
                print("Repop: StepList Contents Empty")
#endif
            } else {
                let fileUrl = getRecipesStepsDirUrl()
#if DEBUG
                print("Repop: Steps url: ", fileUrl)
#endif
                
#if DEBUG
                print("Repop: StepList Contents count: ", contents.count)
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
            print("Repop: not able to read steps")
#endif
        }
    }
    
    func saveStep(step: Step) {
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
    
    func getNextStepIDToUse() -> Int {
        let nextnum = steps.max(by: { $0.number < $1.number })?.number ?? 0 + 1
        return nextnum + 1
    }
    
    func deleteStep(step: Step) {
        self.steps.removeAll(where: { $0 == step })
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


