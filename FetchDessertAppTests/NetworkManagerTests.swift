//
//  NetworkManagerTests.swift
//  FetchDessertAppTests
//
//  Created by Tony Buckner on 11/21/23.
//

import Combine
import XCTest
import FetchDessertApp

class NetworkManagerTests: XCTestCase {
    
    var cancellable = Set<AnyCancellable>()
    
    var mealList: MealListModel?
    var mealListDessertData: Data?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        /// Set initial list from JSON to data
        let mealListFileName = "MealList"
        let jsonFileExtension = "json"
        
        guard let convertedListData = rawDataFromFile(mealListFileName, fileExtension: jsonFileExtension) as? Data else {
            preconditionFailure("Could not find expected file \(mealListFileName) in test bundle.")
        }
        
        mealListDessertData = convertedListData
        mealList = try JSONDecoder().decode(MealListModel.self, from: convertedListData)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkCall() throws {
        NetworkManagerTest.shared.makeCall(withRawData: mealListDessertData,
                                           fromEndpoint: .getMealList(mealCategory: .dessert),
                                           toType: MealListModel.self)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                XCTAssertEqual($0, self.mealList)
            })
            .store(in: &cancellable)
    }

    func testNetworkURL() throws {
        
        XCTAssertEqual("https://themealdb.com/api/json/v1/1/filter.php?a=American", NetworkManagerTest.shared.constructURLComponents(endpoint: .getMealList(mealCategory: .american)).absoluteString)
        
        XCTAssertEqual("https://themealdb.com/api/json/v1/1/filter.php?i=Beef", NetworkManagerTest.shared.constructURLComponents(endpoint: .getMealList(mealCategory: .beef)).absoluteString)
        
        XCTAssertEqual("https://themealdb.com/api/json/v1/1/filter.php?c=Dessert", NetworkManagerTest.shared.constructURLComponents(endpoint: .getMealList(mealCategory: .dessert)).absoluteString)
        
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
