//
//  RecipeModel.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import Foundation
import SwiftUI

// MARK: - Arecipe
struct Arecipe {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let lowFodmap: Bool
    let preparationMinutes, cookingMinutes, aggregateLikes, spoonacularScore: Int
    let healthScore, pricePerServing: Int
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let sourceURL: String
    let image: String
    let imageType: String
    let summary: NSNull
    let cuisines: [String]
    let dishTypes: [Any?]
    let diets: [String]
    let occasions: [Any?]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let sourceName, creditsText, originalID: NSNull
    let recipeUUID: UUID?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable, Hashable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.number == rhs.number && lhs.step == rhs.step
    }
    
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable, Hashable {
    let id: Int
    let name, localizedName, image: String
}

//struct Ingredient: Codable, Hashable {
//    let id: Int
//    let name: String
//}

typealias Ingredient = Ent

// MARK: - Length
struct Length: Codable, Hashable {
    let number: Int
    let unit: String
}

let fluidUnits: [String] = ["milliliter", "liter", "ounce", "fluid ounce", "cup", "pint", "quart", "gallon"]
let cuisines: [String] = [
    "African",
    "American",
    "British",
    "Cajun",
    "Caribbean",
    "Chinese",
    "Eastern European",
    "European",
    "French",
    "German",
    "Greek",
    "Indian",
    "Irish",
    "Italian",
    "Japanese",
    "Jewish",
    "Korean",
    "Latin American",
    "Mediterranean",
    "Mexican",
    "Middle Eastern",
    "Nordic",
    "Southern",
    "Spanish",
    "Thai",
    "Vietnamese"
]

let diets: [String] = []

let reczipesFolderName = "Reczipes"
let recipeNotesFolderName = "RecipeNotes"
let recipeImagesFolderName = "RecipeImages"
let recipeStepsFolderName = "RecipeSteps"


// MARK: - ExtendedIngredient
struct ExtendedIngredient {
    let id: Int
    let aisle, image: String
    let consistency: Consistency
    let name, original, originalString, originalName: String
    let amount: Double
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

enum Consistency: String {
    case liquid
    case solid
}

// MARK: - Measures
struct Measures {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric {
    let amount: Double
    let unitShort, unitLong: String
}

