//
//  Helper.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/17/24.
//

import Foundation

let sampleRecipe: Arecipe = Arecipe(vegetarian: .none, vegan: .none, glutenFree: .none, dairyFree: .none, veryHealthy: .none, cheap: .none, veryPopular: .none, sustainable: .none, weightWatcherSmartPoints: .none, gaps: .none, lowFodmap: .none, preparationMinutes: .none, cookingMinutes: .none, aggregateLikes: .none, spoonacularScore: .none, healthScore: .none, pricePerServing: .none, extendedIngredients: [], id: .none, title: "A Sample Recipe", readyInMinutes: .none, sourceURL: .none, image: .none, imageType: .none, summary: "Please create a sample recipe", cuisines: [], dishTypes: [], diets: [], occasions: [], instructions: "No instructions yet", analyzedInstructions: [], sourceName: "Carol Premji", creditsText: "Carol Premji", originalID: .none, recipeUUID: UUID().uuidString)

let sampleStep: Step = Step(number: Int.random(in: 1...10000), step: "This is the step text", ingredients: [Ent(id: Int.random(in: 1...10000), name: "Ingredient 1 name", localizedName: "Localized Ingredient 1 Name", image: "Image url string")], equipment: [Ent(id: Int.random(in: 1...10000), name: "This is the equipment name", localizedName: "This is the localized equipment name", image: "")], recipeUUID: UUID().uuidString)


let sampleAnalyzedInstruction: AnalyzedInstruction = AnalyzedInstruction(name: "Sample Instruction", steps: [sampleStep], id: UUID())

func getReczipesFolderUrl() -> URL {
    var myReturn:URL
    do {
        let myDocuDirUrl = try FileManager.default.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false)
        myReturn = myDocuDirUrl.appendingPathComponent(reczipesFolderName)
        
        if !FileManager.default.fileExists(atPath: myReturn.path) {
            try FileManager.default.createDirectory(at: myReturn, withIntermediateDirectories: true , attributes: nil)
#if DEBUG
            print("created Recipes directory")
#endif
            return myReturn
        } else {
            return myReturn
            
        }
    } catch {
        fatalError("no user documents directory")
    }
}

func getRecipesAIDirUrl() -> URL {
    let url = getReczipesFolderUrl()
    let aiUrl = url.appendingPathComponent(recipeAnalyzedInstrFolderName)
    
    if !FileManager.default.fileExists(atPath: aiUrl.path) {
        do {
            try FileManager.default.createDirectory(at: aiUrl, withIntermediateDirectories: true, attributes: nil)
#if DEBUG
            print("created Analyzed Instructions directory")
#endif
            return aiUrl
        } catch {
            fatalError("could not create Analyzed Instructions directory")
        }
    }
    return aiUrl
}

func getRecipesStepsDirUrl() -> URL {
    let url = getReczipesFolderUrl()
    let stepsUrl = url.appendingPathComponent(recipeStepsFolderName)
    
    if !FileManager.default.fileExists(atPath: stepsUrl.path) {
        do {
            try FileManager.default.createDirectory(at: stepsUrl, withIntermediateDirectories: true, attributes: nil)
#if DEBUG
            print("created Steps directory")
#endif
            return stepsUrl
        } catch {
            fatalError("could not create Steps directory")
        }
    }
    return stepsUrl
}

func getRecipesImagesDirUrl() -> URL {
    let url = getReczipesFolderUrl()
    let imagesUrl = url.appendingPathComponent(recipeImagesFolderName)
    
    if !FileManager.default.fileExists(atPath: imagesUrl.path) {
        do {
            try FileManager.default.createDirectory(at: imagesUrl, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("could not create Images directory")
        }
    }
    return imagesUrl
}

func getRecipesNotesDirUrl() -> URL {
    let url = getReczipesFolderUrl()
    let notesUrl = url.appendingPathComponent(recipeNotesFolderName)
    
    if !FileManager.default.fileExists(atPath: notesUrl.path) {
        do {
            try FileManager.default.createDirectory(at: notesUrl, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("could not create Notes directory")
        }
    }
    return notesUrl
}

let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumSignificantDigits = 3
    return formatter
}()

/*
 {"vegetarian": false, "vegan": false, "glutenFree": false, "dairyFree": false, "veryHealthy": false, "cheap": false, "veryPopular": false, "sustainable": false, "weightWatcherSmartPoints": false, "gaps": false, "lowFodmap": false, "preparationMinutes": false, "cookingMinutes": false, "aggregateLikes": false, "spoonacularScore": false, "healthScore": false, "pricePerServing": false, "extendedIngredients": [], "id": false, "title": "A Sample Recipe", "readyInMinutes": false, "sourceURL": false, "image": false, "imageType": false, "summary": "Please create a sample recipe", "cuisines": [], "dishTypes": [], "diets": [], "occasions": [], "instructions": "No instructions yet", "analyzedInstructions": [], "sourceName": "Carol Premji", "creditsText": "Carol Premji", "originalID": false, "recipeUUID": ""}

 */
