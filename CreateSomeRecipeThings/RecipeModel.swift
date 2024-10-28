//
//  RecipeModel.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import Foundation
import SwiftUI


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
let equip_list_shipped = Bundle.main.url(forResource: "equipment_list", withExtension: "json")
let ingred_list_shipped = Bundle.main.url(forResource:"ingredients_list", withExtension: "json")

let reczipesFolderName = "Reczipes"
let recipeNotesFolderName = "RecipeNotes"
let recipeImagesFolderName = "RecipeImages"
let recipeStepsFolderName = "RecipeSteps"
let recipeAnalyzedInstrFolderName = "RecipeInstructions"


// MARK: - Arecipe
struct Arecipe: Codable, Identifiable, Hashable {
    var vegetarian, vegan, glutenFree, dairyFree: Bool?
    var veryHealthy, cheap, veryPopular, sustainable: Bool?
    var weightWatcherSmartPoints: Int?
    var gaps: String?
    var lowFodmap: Bool?
    var preparationMinutes, cookingMinutes, aggregateLikes, spoonacularScore: Int?
    var healthScore, pricePerServing: Int?
    var extendedIngredients: [ExtendedIngredient?]
    var id: Int?
    var title: String
    var readyInMinutes: Int?
    var sourceURL: String?
    var image: String?
    var imageType: String?
    var summary: String
    var cuisines: [String?]
    var dishTypes: [String?]
    var diets: [String?]
    var occasions: [String?]
    var instructions: String?
    var analyzedInstructions: [AnalyzedInstruction?]
    var sourceName, creditsText, originalID: String?
    var recipeUUID: String
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable, Equatable, Identifiable, Hashable {
    var name: String = "Please provide an instruction name"
    var steps: [Step] = []
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
    
    var number: Int
    var step: String
    var ingredients, equipment: [Ent]
    var recipeUUID: String
}

// MARK: - Ent
struct Ent: Codable, Hashable {
    var id: Int
    var name, localizedName, image: String
    var amount: Length?
}

typealias Ingredient = Ent

// MARK: - Length
struct Length: Codable, Hashable {
    var number: Int
    var unit: String
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Equatable, Identifiable, Hashable {
    var id: Int
    var aisle, image: String
    var consistency: Consistency
    var name, original, originalString, originalName: String
    var amount: Double
    var unit: String
    var meta, metaInformation: [String]
    var measures: Measures
}

enum Consistency: Codable, Equatable {
    case liquid
    case solid
}

// MARK: - Measures
struct Measures: Codable, Equatable, Hashable {
    var us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable, Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    var amount: Double
    var unitShort, unitLong: String
}

