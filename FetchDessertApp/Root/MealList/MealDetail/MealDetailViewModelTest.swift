//
//  MealDetailViewModelTest.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/29/23.
//

import Foundation

// MARK: - Test View Model

/// - Note: This needed to be separated due to test additions being omitted due to core data being added

class MealDetailViewModelTest: MealDetailViewModelProtocol {
    
    var model: MealDetailModel?
    
    init(data: Data) {
        getMeal(withTestFileData: data, fromId: "") { _ in }
    }
    
    func getMeal(withTestFileData fileData: Data?, fromId id: String, status: @escaping (Bool) -> ()) {
        model = try? JSONDecoder().decode(MealDetailModel.self, from: fileData!)
    }
    
}
