//
//  RecipeModel.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import Foundation
import SwiftUI

// MARK: - Arecipe
struct Arecipe: Codable, Identifiable, Hashable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let lowFodmap: Bool?
    let preparationMinutes, cookingMinutes, aggregateLikes, spoonacularScore: Int?
    let healthScore, pricePerServing: Int?
    let extendedIngredients: [ExtendedIngredient?]
    let id: Int?
    let title: String
    let readyInMinutes: Int?
    let sourceURL: String?
    let image: String?
    let imageType: String?
    let summary: String
    let cuisines: [String?]
    let dishTypes: [String?]
    let diets: [String?]
    let occasions: [String?]
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction?]
    let sourceName, creditsText, originalID: String?
    let recipeUUID: UUID?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable, Equatable, Identifiable, Hashable {
    let name: String
    let steps: [Step]
    var id: UUID = UUID()
}

// MARK: - Step
struct Step: Codable, Hashable, Comparable {
    static func < (lhs: Step, rhs: Step) -> Bool {
        lhs.number < rhs.number
    }
    
    static func > (lhs: Step, rhs: Step) -> Bool {
        lhs.number > rhs.number
    }
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.number == rhs.number && lhs.step == rhs.step
    }
    
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let recipeUUID: UUID
}

// MARK: - Ent
struct Ent: Codable, Hashable {
    let id: Int
    let name, localizedName, image: String
    let amount: Length?
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
let volumeUnits: [String] = ["teaspoon", "tablespoon", "cup", "pint", "quart", "gallon", "milliliter", "liter", "ounce", "pound", "gram", "kilogram"]
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
struct ExtendedIngredient: Codable, Equatable, Identifiable, Hashable {
    let id: Int
    let aisle, image: String
    let consistency: Consistency
    let name, original, originalString, originalName: String
    let amount: Double
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

enum Consistency: Codable, Equatable {
    case liquid
    case solid
}

// MARK: - Measures
struct Measures: Codable, Equatable, Hashable {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable, Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    let amount: Double
    let unitShort, unitLong: String
}

