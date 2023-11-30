//
//  ReactiveTests.swift
//  FetchDessertAppTests
//
//  Created by Tony Buckner on 11/27/23.
//

import Combine
import XCTest

class ReactiveTests: XCTestCase {
    
    //var reactivePublisher: ReactivePublisher?
    //let reactiveSubscriber = ReactiveSubscriber()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //reactivePublisher = ReactivePublisher()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    /// Under construction
    /*func testReactive() throws {
        
        let testFavorite1 = Meal(strMeal: "Meal One", strMealThumb: "NA", idMeal: "1")
        let testFavorite2 = Meal(strMeal: "Meal Two", strMealThumb: "NA", idMeal: "2")
        let testFavorite3 = Meal(strMeal: "Meal Three", strMealThumb: "NA", idMeal: "3")
        
        reactivePublisher?.updateFavoritesList.send(testFavorite1)
        
        XCTAssertEqual("1", reactivePublisher?.favoritesList.value[Int(testFavorite1.idMeal) ?? 0]?.idMeal)
         
    }*/

}
