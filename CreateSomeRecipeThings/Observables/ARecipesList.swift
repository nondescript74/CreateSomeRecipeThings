//
//  ARecipesList.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/29/24.
//

import SwiftUI

class ARecipesList: ObservableObject {
    @Published var userRecipes: [Arecipe] = []
    @Published var currentRecipe: Arecipe = sampleRecipe
    
    init() {
        do  {
            let reczipesDir = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().path)
#if DEBUG
            print("Recipes folder contents:", reczipesDir)
#endif
            do {
                let arecipesDir = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().appendingPathComponent("Arecipes").path)
                if arecipesDir.isEmpty {
                    setCurrentRecipe(arecipe: sampleRecipe)
                } else {
                    let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
                    for aurl in arecipesDir {
                        let url = arecipesUrl.appendingPathComponent(aurl)
#if DEBUG
                        print("Arecipe url from directory: ", url)
#endif
                        let arecipe = try JSONDecoder().decode(Arecipe.self, from: try! Data(contentsOf: url))
                        self.userRecipes.append(arecipe)
                        setCurrentRecipe(arecipe: arecipe)
                    }
                }
            }
        } catch {
            // no directory, create
            // no Arecipes directory, create
            do {
                let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
                try FileManager.default.createDirectory(at: arecipesUrl, withIntermediateDirectories: true)
#if DEBUG
                print("Created Arecipes directory")
#endif
            } catch {
                fatalError("Could not create Arecipes directory")
            }
        }
        
        
#if DEBUG
        print("User recipes has count: ", userRecipes.count.description)
        print("Current recipe is ", userRecipes.last?.title ?? "No title?")
#endif
        
    }
    
    func setCurrentRecipe(arecipe: Arecipe) {
        currentRecipe = arecipe
#if DEBUG
        print("Current recipe: ", currentRecipe.title)
#endif
    }
    
    
    func addRecipe(arecipe: Arecipe) {
        if userRecipes.contains(where: { $0.recipeUUID == arecipe.recipeUUID }) {
#if DEBUG
            print("Recipe already exists, removing it", "userRecipes: ", userRecipes.count.description)
            print("Removing: ", arecipe.title, arecipe.recipeUUID)
#endif
            self.userRecipes.removeAll(where: { $0.id == arecipe.id })
        }
        self.userRecipes.append(arecipe)
        setCurrentRecipe(arecipe: arecipe)
#if DEBUG
        print("Added recipe: ", arecipe.title)
        print("Current recipe: ", currentRecipe.title)
#endif
        
        let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes").appendingPathComponent("\(currentRecipe.title).json")
        
        do {
            try JSONEncoder().encode(arecipe).write(to: arecipesUrl)
#if DEBUG
            print("Saved Arecipe: ", arecipe.title)
            print("Saved Arecipe to: ", arecipesUrl)
#endif
        } catch {
            print("Error saving Arecipe: \(error)")
        }
    }
    
    func removeRecipe(arecipe: Arecipe) {
        if self.userRecipes.contains(arecipe) {
            self.userRecipes.removeAll(where: { $0.title == arecipe.title || $0.recipeUUID == arecipe.recipeUUID })
            setCurrentRecipe(arecipe: self.userRecipes.first ?? sampleRecipe)
#if DEBUG
            print("Removed recipe: ", arecipe.recipeUUID, "set current recipe to ", currentRecipe.title)
#endif
        } else {
            
#if DEBUG
            print("userRecipes does not contain: ", arecipe.recipeUUID)
#endif
        }
    }
}

