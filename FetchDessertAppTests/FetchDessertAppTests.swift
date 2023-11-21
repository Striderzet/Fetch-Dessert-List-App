//
//  FetchDessertAppTests.swift
//  FetchDessertAppTests
//
//  Created by Tony Buckner on 11/14/23.
//

import XCTest
import FetchDessertApp

class FetchDessertAppTests: XCTestCase {
    
    // Classes
    
    var mealListViewModel: MealListViewModelTest?
    var mealListDetailViewModel: MealDetailViewModelTest?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        /// Set initial list from JSON to data
        let mealListFileName = "MealList"
        let mealDetailFileName = "MealDetail"
        let jsonFileExtension = "json"
        
        guard let convertedListData = rawDataFromFile(mealListFileName, fileExtension: jsonFileExtension) as? Data else {
            preconditionFailure("Could not find expected file \(mealListFileName) in test bundle.")
        }
        
        guard let convertedMealData = rawDataFromFile(mealDetailFileName, fileExtension: jsonFileExtension) as? Data else {
            preconditionFailure("Could not find expected file \(mealDetailFileName) in test bundle.")
        }
        
        mealListViewModel = MealListViewModelTest(testData: convertedListData)
        mealListDetailViewModel = MealDetailViewModelTest(data: convertedMealData)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mealListViewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test cases (positive only)
    
    /// Run test comparison for first few separated values
    func testListConversion() throws {
        if let meal = mealListViewModel?.model?.meals[0] {
            XCTAssertLessThanOrEqual("Apam balik", meal.strMeal)
            XCTAssertLessThanOrEqual("53049", meal.idMeal)
        }
        
        if let meal = mealListViewModel?.model?.meals[5] {
            XCTAssertLessThanOrEqual("Battenberg Cake", meal.strMeal)
            XCTAssertLessThanOrEqual("52894", meal.idMeal)
        }
        
        if let meal = mealListViewModel?.model?.meals[10] {
            XCTAssertLessThanOrEqual("Canadian Butter Tarts", meal.strMeal)
            XCTAssertLessThanOrEqual("52923", meal.idMeal)
        }
    }
    
    func testMealConversion() throws {
        if let mealDetails = mealListDetailViewModel?.model?.meals[0] {
            XCTAssertLessThanOrEqual("52990", mealDetails.idMeal)
            XCTAssertLessThanOrEqual("Christmas cake", mealDetails.strMeal)
            XCTAssertLessThanOrEqual("Dessert", mealDetails.strCategory)
            XCTAssertLessThanOrEqual("British", mealDetails.strArea)
        }
    }
    
    // Reusable methods
    
    func rawDataFromFile(_ fileName: String, fileExtension: String) -> Any? {

        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: fileName, withExtension: fileExtension)

        do {
            guard let fullUrl = url else {
                return .none
            }
            let data = try Data(contentsOf: fullUrl)

            return data
        } catch {
            return .none
        }
    }

}
