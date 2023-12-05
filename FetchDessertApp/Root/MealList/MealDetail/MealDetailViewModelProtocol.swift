//
//  MealDetailViewModelProtocol.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/20/23.
//

import Foundation

protocol MealDetailViewModelProtocol {
    var model: MealDetailModel? { get set }
    func getMeal(withTestFileData fileData: Data?, fromId id: String, status: @escaping(_ complete: Bool) -> ())
}
