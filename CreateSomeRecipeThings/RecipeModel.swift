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
struct Step {
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
struct Length {
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

let recipesName = "Reczipes"
let recipeNotesFolderName = "RecipeNotes"
let recipeImagesFolderName = "RecipeImages"
let recipeIngredientsFolderName = "RecipeIngredients"
let rnotes = "RecipeNotes"
let rimages = "RecipeImages"

let suitImage =  UIImage(systemName: "suit.heart")!
let checkmarkImage = UIImage(systemName: "checkmark.seal")!
let lassoImage = UIImage(systemName: "lasso")!
let wandNStarsImage = UIImage(systemName: "wand.and.stars")!
let rectandtextmagglass = UIImage(systemName: "rectangle.and.text.magnifyingglass")
let docandtextmagglass = UIImage(systemName: "doc.text.magnifyingglass")
let crosscirclefill = UIImage(systemName: "cross.circle.fill")
let tortoise = UIImage(systemName: "tortoise")
let hare = UIImage(systemName: "hare")
let imageSquarePencil = UIImage(systemName: "square.and.pencil")
let imageSuitSpadeEmpty = UIImage(systemName: "suite.spade")
let imageDocDocEmpty = UIImage(systemName: "doc.on.doc")
let imageDocDocFill = UIImage(systemName: "doc.on.doc.fill")
let scribblevariable = UIImage(systemName: "scribble.variable")
let rectstackbadgepersoncrop = UIImage(systemName: "rectangle.stack.badge.person.crop")
let questionmarkcircle = UIImage(systemName: "questionmark.circle")
let folderfillbadgeplus = UIImage(systemName: "folder.fill.badge.plus")
let magnifyingglass = UIImage(systemName: "magnifyingglass")
let lassosparkles = UIImage(systemName: "lasso.sparkles")
let squareandarrowdown = UIImage(systemName:"square.and.arrow.down")
let shareImage = UIImage(systemName: "square.and.arrow.up")
let videobadgeplus = UIImage(systemName:"video.badge.plus")


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

