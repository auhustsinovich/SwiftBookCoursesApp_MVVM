//
//  CourseCellView.swift
//  SwiftBookCoursesApp_MVVM
//
//  Created by Daniil Auhustsinovich on 15.08.22.
//

import UIKit

class CourseCellView: UITableViewCell {
    var courseCellViewModel: CourseCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = courseCellViewModel.courseName
            guard let imageData = courseCellViewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            contentConfiguration = content
        }
    }
}
