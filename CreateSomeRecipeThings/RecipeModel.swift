//
//  RecipeModel.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/7/24.
//

import Foundation

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
struct Ent {
    let id: Int
    let name, localizedName, image: String
}

// MARK: - Length
struct Length {
    let number: Int
    let unit: String
}

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

