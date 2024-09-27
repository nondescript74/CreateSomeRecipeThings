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
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
#if DEBUG
                    print("AInstruction url: ", url)
#endif
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
    
    func add(_ instruction: AnalyzedInstruction) {
        if self.instructions.contains(where: { $0.id == instruction.id }) {
            remove(instruction)
        }
        self.instructions.append(instruction)
#if DEBUG
        print("AInstr Added: ", self.instructions, "Count is now: ", self.instructions.count, "\n")
#endif
        
        let arecipesAIUrl = getRecipesAIDirUrl().appendingPathComponent(instruction.name + ".json")
        do {
            try JSONEncoder().encode(instruction).write(to: arecipesAIUrl)
#if DEBUG
            print("Saved Analyzed Instruction to: ", arecipesAIUrl, "\n")
#endif
        } catch {
            print("Error saving AInstr: \(error)")
        }
        
    }
    
    func remove(_ instruction: AnalyzedInstruction) {
        self.instructions.removeAll(where: { $0.id == instruction.id })
#if DEBUG
        print("Removed: ", self.instructions)
#endif
    }
    
//    func upDateAInstr() {
//        do  {
//            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesAIDirUrl().path)
//#if DEBUG
//            print("Update Analyzed Instructions, Contents", contents)
//#endif
//            if contents.isEmpty {
//#if DEBUG
//                print("Update Analyzed Instructions, Contents Empty")
//#endif
//                self.instructions = []
//            } else {
//                let fileUrl = getRecipesAIDirUrl()
//#if DEBUG
//                print("Update Analyzed Instructions from file:", fileUrl)
//#endif
//                for aurl in contents {
//                    let url = fileUrl.appendingPathComponent(aurl)
//                    //#if DEBUG
//                    //                    print("Update Steps, Step url: ", url)
//                    //#endif
//                    let anAI = try JSONDecoder().decode(AnalyzedInstruction.self, from: try! Data(contentsOf: url))
//                    if !self.instructions.contains(anAI) {
//                        self.instructions.append(anAI)
//                    }
//                }
//            }
//        } catch {
//#if DEBUG
//            print("not able to read Analyzed Instructions")
//#endif
//            self.instructions = []
//        }
//    }
}
