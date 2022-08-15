//
//  Course.swift
//  SwiftBookCoursesApp_MVVM
//
//  Created by Daniil Auhustsinovich on 15.08.22.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL
    let numberOfLessons: Int
    let numberOfTests: Int
}
