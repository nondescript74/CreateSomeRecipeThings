//
//  UserRecipes.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/20/24.
//

import Foundation

final class UserRecipes: ObservableObject {
    @Published var userrecipes: [Arecipe] = []
    @Published var currentRecipe: Arecipe = sampleRecipe
    
    
    init() {
        do  {
            let reczipesDir = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().path)
#if DEBUG
            print("Recipes folder contents:", reczipesDir)
#endif
            do {
                _ = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().appendingPathComponent("Arecipes").path)
            } catch {
                // no Arecipes directory, create
                do {
                    let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
                    try FileManager.default.createDirectory(at: arecipesUrl, withIntermediateDirectories: true)
                    
                } catch {
                    fatalError("Could not create Arecipes directory")
                }
            }
            let arecipesDir = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().appendingPathComponent("Arecipes").path)
#if DEBUG
                print("Arecipes folder contents count: ", userrecipes.count)
#endif
            if arecipesDir.isEmpty {
                currentRecipe = sampleRecipe
                userrecipes.append(sampleRecipe)
                
                #if DEBUG
                print("Created a sample Arecipe, added it to user recipes")
                print("User recipes now has count: ", userrecipes.count.description)
                #endif
            } else {
                let arecipesDir = try FileManager.default.contentsOfDirectory(atPath: getReczipesFolderUrl().appendingPathComponent("Arecipes").path)
                let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
                for aurl in arecipesDir {
                    let url = arecipesUrl.appendingPathComponent(aurl)
#if DEBUG
                    print("Arecipe url: ", url)
#endif
                    let arecipe = try JSONDecoder().decode(Arecipe.self, from: try! Data(contentsOf: url))
                    self.userrecipes.append(arecipe)
                    self.currentRecipe = arecipe
#if DEBUG
                    print("Set current recipe to: ", arecipe.title)
#endif
                }
            }
        } catch {
            fatalError("Could not read recipes folder: \(error)")
        }
    }
    
    @MainActor
    func addRecipe(_ arecipe: Arecipe) {
        if userrecipes.contains(where: { $0.id == arecipe.id }) {
#if DEBUG
            print("Recipe already exists, removing it")
#endif
            self.userrecipes.removeAll(where: { $0.id == arecipe.id })
        }
        self.userrecipes.append(arecipe)
        self.currentRecipe = arecipe
#if DEBUG
        print("Added recipe: ", arecipe.title)
#endif
    }
    
    func removeRecipe(_ arecipe: Arecipe) {
        self.userrecipes.removeAll(where: { $0.id == arecipe.id })
        self.currentRecipe = sampleRecipe
#if DEBUG
        print("Removed recipe: ", arecipe.title)
#endif
    }
    
    func saveRecipe() {
        let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
        do {
            try JSONEncoder().encode(currentRecipe).write(to: arecipesUrl)
#if DEBUG
            print("Saved Arecipe: ", currentRecipe.title)
            print("Saved Arecipe to: ", arecipesUrl)
#endif
        } catch {
            print("Error saving step: \(error)")
        }
    }
}
