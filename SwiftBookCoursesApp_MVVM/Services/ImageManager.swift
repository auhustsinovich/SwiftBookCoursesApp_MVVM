//
//  ImageManager.swift
//  SwiftBookCoursesApp_MVVM
//
//  Created by Daniil Auhustsinovich on 15.08.22.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
