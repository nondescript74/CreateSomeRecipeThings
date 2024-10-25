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
                    currentRecipe = sampleRecipe
                } else {
                    let arecipesUrl = getReczipesFolderUrl().appendingPathComponent("Arecipes")
                    for aurl in arecipesDir {
                        let url = arecipesUrl.appendingPathComponent(aurl)
                        //#if DEBUG
                        //                    print("Arecipe url: ", url)
                        //#endif
                        let arecipe = try JSONDecoder().decode(Arecipe.self, from: try! Data(contentsOf: url))
                        self.userRecipes.append(arecipe)
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
#endif
    
    }
    

    func addRecipe(_ arecipe: Arecipe) {
        if userRecipes.contains(where: { $0.id == arecipe.id }) {
#if DEBUG
            print("Recipe already exists, removing it")
#endif
            self.userRecipes.removeAll(where: { $0.id == arecipe.id })
        }
        self.userRecipes.append(arecipe)
        self.currentRecipe = arecipe
#if DEBUG
        print("Added recipe: ", arecipe.title)
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
 
    func removeRecipe(_ arecipe: Arecipe) {
        self.userRecipes.removeAll(where: { $0.id == arecipe.id })
        self.currentRecipe = sampleRecipe
#if DEBUG
        print("Removed recipe: ", arecipe.title)
#endif
    }
    
    func removeRecipe(_ title: String) {
        self.userRecipes.removeAll(where: { $0.title == title })
        self.currentRecipe = sampleRecipe
#if DEBUG
        print("Removed Arecipe: ", title)
#endif
    }

}

