//
//  AnalyzedInstructionList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/24/24.
//

import Foundation

class AnalyzedInstructionList: ObservableObject {
    
    @Published var instructions: [AnalyzedInstruction] = []
    
    init() {
        do  {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesAIDirUrl().path)
#if DEBUG
            print("AI Contents", contents)
#endif
            if contents.isEmpty {
#if DEBUG
                print("AI Contents Empty")
#endif
                
            } else {
                let fileUrl = getRecipesAIDirUrl()
#if DEBUG
                print("AI url: ", fileUrl)
#endif
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
//#if DEBUG
//                    print("Step url: ", url)
//#endif
                    let anAI = try JSONDecoder().decode(AnalyzedInstruction.self, from: try! Data(contentsOf: url))
                    instructions.append(anAI)
                }
            }
        } catch {
#if DEBUG
            print("not able to read instuctions: ", error, "\n")
#endif
            self.instructions = []
        }
    }
    
    @MainActor
    func add(_ instruction: AnalyzedInstruction) {
        if self.instructions.contains(where: { $0.id == instruction.id }) {
            remove(instruction)
        }
        self.instructions.append(instruction)
#if DEBUG
        print("Added: ", self.instructions)
#endif
        
        let arecipesAIUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes").appendingPathComponent(recipeAnalyzedInstrFolderName)
        do {
            try JSONEncoder().encode(instructions).write(to: arecipesAIUrl)
#if DEBUG
            print("Instructions count: ", self.instructions.count, "\n")
            print("Saved A Instructions to: ", arecipesAIUrl, "\n")
            print("Instructions count: ", self.instructions.count, "\n")
#endif
        } catch {
            print("Error saving step: \(error)", "\n")
        }
        
    }
    
    @MainActor
    func remove(_ instruction: AnalyzedInstruction) {
        self.instructions.removeAll(where: { $0.id == instruction.id })
#if DEBUG
        print("Removed: ", self.instructions)
#endif
    }
    
    @MainActor
    func upDateAInstr() {
        do  {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesAIDirUrl().path)
#if DEBUG
            print("Update Analyzed Instructions, Contents", contents)
#endif
            if contents.isEmpty {
#if DEBUG
                print("Update Analyzed Instructions, Contents Empty")
#endif
                self.instructions = []
            } else {
                let fileUrl = getRecipesAIDirUrl()
#if DEBUG
                print("Update Analyzed Instructions from file:", fileUrl)
#endif
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
                    //#if DEBUG
                    //                    print("Update Steps, Step url: ", url)
                    //#endif
                    let anAI = try JSONDecoder().decode(AnalyzedInstruction.self, from: try! Data(contentsOf: url))
                    if !self.instructions.contains(anAI) {
                        self.instructions.append(anAI)
                    }
                }
            }
        } catch {
#if DEBUG
            print("not able to read Analyzed Instructions")
#endif
            self.instructions = []
        }
    }
}
