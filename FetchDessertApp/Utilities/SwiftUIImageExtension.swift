//
//  SwiftUIImageExtension.swift
//  FetchDessertApp
//
//  Created by Tony Buckner on 11/9/23.
//

import Foundation
import SwiftUI

/// - Note: This needs to be working in the background thread

/// The reason for this public method is that I am running Xcode 12.5.1 and "AsyncImage" does not exist. Therefore, I have to recreate it here
/// - Parameter imageUrl: The origin of the desired image to be presented
/// - Returns: An Image view presenting the desired image
public func AsyncImageCustom(imageUrl: String) -> Image {
    if let data = try? Data(contentsOf: URL(string: imageUrl) ?? URL(fileURLWithPath: "")) {
        return Image(uiImage: UIImage(data: data)!)
            .resizable()
    } else {
        return Image(systemName: "sparkles")
            .resizable()
    }
}
