//
//  CourseListViewController.swift
//  SwiftBookCoursesApp_MVVM
//
//  Created by Daniil Auhustsinovich on 15.08.22.
//

import UIKit

class CourseListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView?
    private var courseListViewModel: CourseListViewModelProtocol! {
        didSet {
            courseListViewModel.fetchCourses { [unowned self] in
                self.tableView.reloadData()
                self.activityIndicator?.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseListViewModel = CourseListViewModel()
        tableView.rowHeight = 100
        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! CourseDetailsViewController
        detailVC.courseDetailsViewModel = sender as? CourseDetailsViewModel
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courseListViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCellView
        cell.courseCellViewModel = courseListViewModel.getCourseCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let courseDetailsViewModel = courseListViewModel.getCourseDetailsViewModel(at: indexPath)
        performSegue(withIdentifier: "ShowDetails", sender: courseDetailsViewModel)
    }
}
