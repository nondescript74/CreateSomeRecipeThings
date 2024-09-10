//
//  SelectIngredientView.swift
//  CreateSomeRecipeThings
//
//  Created by Zahirudeen Premji on 9/9/24.
//

import SwiftUI

struct SelectIngredientView: View {
    
    @State fileprivate var selectedIngredient: Ingredient
    fileprivate var ingredients: [Ingredient]
    let recipesName = "Reczipes"
    let recipeNotesFolderName = "RecipeNotes"
    let recipeImagesFolderName = "RecipeImages"
    let recipeIngredientsFolderName = "RecipeIngredients"
    let rnotes = "RecipeNotes"
    let rimages = "RecipeImages"
    
    func getDocuDirUrl() -> URL {
        var myReturn:URL
        do {
            let myDocuDirUrl = try FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false)
            myReturn = myDocuDirUrl
        } catch {
            fatalError("no user documents directory")
        }
        return myReturn
    }
    
    func getUserDirectoriesUrls() -> [URL] {
        var urls:[URL] = [URL]()
        do {
            urls = try FileManager.default.contentsOfDirectory(at: getDocuDirUrl().appendingPathComponent(recipesName), includingPropertiesForKeys: [], options: .skipsHiddenFiles)
        } catch {
            // directories not yet created
            fatalError("no user documents directory")
        }
        return urls
    }
    
    func getIngredientsDirUrl() -> URL {
        let urls = getUserDirectoriesUrls()
        let dirUrl = urls.first(where: {$0.pathComponents.contains(recipeIngredientsFolderName)})!
        return dirUrl
    }
    

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
    }
    
}



//#Preview {
//    SelectIngredientView()
//}
