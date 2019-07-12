//
//  PerformanceTableViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit
import CoreData

protocol PerformanceTableViewDelegate: class {
    
}

class PerformanceTableViewController: UITableViewController {

    static let sectionNumber = 1
    
    weak var delegate: PerformanceTableViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allQuestions = coreDataFetchController.getAllQuestion() ?? []
        correctlyAnsweredQuestions = coreDataFetchController.getQuestionAnsweredCorrectly() ?? []
        questionObservations = coreDataFetchController.getAllQuestionObservations() ?? []
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        tableView.register(PerformanceTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        darkModeConformingStyle(tableView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PerformanceTableViewController.sectionNumber
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Category.allCases.count
        default:
            fatalError("There should only be \(PerformanceTableViewController.sectionNumber) sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        darkModeConformingStyle(view)
        view.constrain(height: 60)
        let label = UILabel()
        label.text = "Progress towards mastery"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .fadedTextColor
        label.constrainToSuperView(view, bottom: 0, leading: 20, trailing: 20)
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? PerformanceTableViewCell else { fatalError("Could not dequeue cell as a PerformanceTableViewCell")}
        
        let category: Category
        switch indexPath.section {
        case 0:
            category = Category.allCases.reversed()[indexPath.row]
        default:
            fatalError("There should only be \(PerformanceTableViewController.sectionNumber) sections")
        }
        
        cell.category = category
        if category == .All {
            cell.categoryQuestions = self.allQuestions
            cell.categoryMasteredQuestions = self.correctlyAnsweredQuestions
        } else {
            cell.categoryQuestions = self.allQuestions.filter({ $0.category == category.rawValue })
            cell.categoryMasteredQuestions = self.correctlyAnsweredQuestions.filter({ $0.category == category.rawValue })
        }
        darkModeConformingStyle(cell)
        
        return cell
    }
    
    // MARK: - Properties
    let cellID = "cellID"
    var coreDataFetchController: CoreDataFetchController = CoreDataFetchController()
    lazy var allQuestions: [Question] = {
        return coreDataFetchController.getAllQuestion() ?? []
    }()
    lazy var correctlyAnsweredQuestions: [Question] = {
        return coreDataFetchController.getQuestionAnsweredCorrectly() ?? []
    }()
    lazy var questionObservations: [QuestionObservation] = {
        return coreDataFetchController.getAllQuestionObservations() ?? []
    }()
    
    

}
