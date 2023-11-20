//
//  MealDetailModel.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation

struct MealDetailModel: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Decodable {
    
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    enum CodingKeys: CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
    }
     
    let strMeasure: [Int: String]?
    let strIngredient: [Int: String]?
    
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
    
    
    init(from decoder: Decoder) throws {
        
        // decode all first vars first
        
        let normalContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try normalContainer.decode(String.self, forKey: .idMeal)
        strMeal = try normalContainer.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try? normalContainer.decode(String.self, forKey: .strDrinkAlternate)
        strCategory = try normalContainer.decode(String.self, forKey: .strCategory)
        strArea = try normalContainer.decode(String.self, forKey: .strArea)
        strInstructions = try normalContainer.decode(String.self, forKey: .strInstructions)
        strMealThumb = try? normalContainer.decode(String.self, forKey: .strMealThumb)
        strTags = try? normalContainer.decode(String.self, forKey: .strTags)
        strYoutube = try? normalContainer.decode(String.self, forKey: .strYoutube)
        strSource = try? normalContainer.decode(String.self, forKey: .strSource)
        strImageSource = try? normalContainer.decode(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try? normalContainer.decode(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try? normalContainer.decode(String.self, forKey: .dateModified)
        
        // now decode dynamic objects
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
    
        var tempIngredientArray = [Int: String]()
        var tempMeasurementArray = [Int: String]()
        
        for key in container.allKeys {
            
            if let decodedObject = try? container.decode(String.self, forKey: key), decodedObject != "" {
                
                // Add to ingredient array
                if key.stringValue.hasPrefix("strIngredient") {
                    let ingredientKeyValue = key.stringValue.replacingOccurrences(of: "strIngredient", with: "")
                    if let ingredientKey = Int(ingredientKeyValue) {
                        tempIngredientArray[ingredientKey] = decodedObject
                    }
                }
                
                // Add to measurement array
                if key.stringValue.hasPrefix("strMeasure") {
                    let measurementKeyValue = key.stringValue.replacingOccurrences(of: "strMeasure", with: "")
                    if let measurementKey = Int(measurementKeyValue) {
                        tempMeasurementArray[measurementKey] = decodedObject
                    }
                }
            }
            
        }
        
        strMeasure = tempMeasurementArray
        strIngredient = tempIngredientArray
        
    }
    
}

