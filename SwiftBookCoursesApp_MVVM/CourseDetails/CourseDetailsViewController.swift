//
//  CourseDetailsViewController.swift
//  SwiftBookCoursesApp_MVVM
//
//  Created by Daniil Auhustsinovich on 15.08.22.
//

import UIKit

class CourseDetailsViewController: UIViewController {

    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessonsLabel: UILabel!
    @IBOutlet var numberOfTestsLabel: UILabel!
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    
    var courseDetailsViewModel: CourseDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func toggleFavourite(_ sender: UIButton) {
        courseDetailsViewModel.favoriteButtonPressed()
    }
    private func setupUI() {
        setStatusForFavoriteButton(courseDetailsViewModel.isFavorite)
        
        courseDetailsViewModel.viewModelDidChange = { [weak self] viewModel in
            self?.setStatusForFavoriteButton(viewModel.isFavorite)
        }
        
        courseNameLabel.text = courseDetailsViewModel.courseName
        numberOfLessonsLabel.text = courseDetailsViewModel.numberOfLessons
        numberOfTestsLabel.text = courseDetailsViewModel.numberOfTests
        courseImage.image = UIImage(data: courseDetailsViewModel.imageData ?? Data())
    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}

