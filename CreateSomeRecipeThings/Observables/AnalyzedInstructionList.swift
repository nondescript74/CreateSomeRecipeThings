//
//  AnalyzedInstructionList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/24/24.
//

import Foundation

final class AnalyzedInstructionList: ObservableObject {
    
    @Published var instructions: [AnalyzedInstruction] = []
    
    init() {
        do  {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesAIDirUrl().path)
#if DEBUG
            print("AIList: ", "AI Contents", contents)
#endif
            if contents.isEmpty {
#if DEBUG
                print("AIList: ", "AI Contents Empty")
#endif
                
            } else {
                let fileUrl = getRecipesAIDirUrl()
                for aurl in contents {
                    let url = fileUrl.appendingPathComponent(aurl)
#if DEBUG
                    print("AIList: ", "AInstruction url: ", url)
#endif
                    let anAI = try JSONDecoder().decode(AnalyzedInstruction.self, from: try! Data(contentsOf: url))
                    instructions.append(anAI)
                }
            }
        } catch {
#if DEBUG
            print("AIList: ", "not able to read instuctions: ", error, "\n")
#endif
            self.instructions = []
        }
#if DEBUG
        print("AIList: analyzed instruction list: \(self.instructions)")
#endif
    
    }
    
    func save(_ instruction: AnalyzedInstruction) {
        self.remove(instruction)
        self.instructions.append(instruction)
#if DEBUG
        print("AIList Added: ", self.instructions, "Count is now: ", self.instructions.count, "\n")
#endif
        
        let arecipesAIUrl = getRecipesAIDirUrl().appendingPathComponent(instruction.name + ".json")
        do {
            try JSONEncoder().encode(instruction).write(to: arecipesAIUrl)
#if DEBUG
            print("AIList Saved Analyzed Instruction to: ", arecipesAIUrl, "\n")
#endif
        } catch {
            print("Error saving AInstr: \(error)")
        }
    }
    
    func remove(_ instruction: AnalyzedInstruction) {
        if let _ = self.instructions.firstIndex(of: instruction) {
            self.instructions.removeAll(where: { $0.id == instruction.id })
            deleteAnalyInstrInStorage(instruction: instruction)
    #if DEBUG
            print("AIList Removed AInstr: ", self.instructions)
    #endif
        }
    }
    
    fileprivate func deleteAnalyInstrInStorage(instruction: AnalyzedInstruction) {
        let aiDir = getRecipesAIDirUrl()
        let aiFileUrl = aiDir.appendingPathComponent(instruction.name.replacingOccurrences(of: " ", with: "_").appending(".json"))
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: getRecipesAIDirUrl().path)
            if contents.contains(aiFileUrl.lastPathComponent) {
#if DEBUG
                print("AIList Found analyzed instruction in aiurl: \(aiFileUrl)")
#endif
                do {
                    let data = try Data(contentsOf: aiFileUrl)
                    try data.write(to: aiFileUrl, options: .atomic)
                    try FileManager.default.removeItem(at: aiFileUrl)
#if DEBUG
                    print("AIList Deleted analyzed instruction from aiurl: \(aiFileUrl)")
#endif
                } catch {
                    #if DEBUG
                    print("AIList Error deleting AnalyzedInstruction: \(error)")
                    #endif
                }
            } else {
#if DEBUG
                print("AIList No analyzed instruction found at aiurl: \(aiFileUrl)")
#endif
            }
        } catch {
            #if DEBUG
            print("AIList Error getting AnalyzedInstructions contents: \(error)")
#endif
        }
    }
    

}
