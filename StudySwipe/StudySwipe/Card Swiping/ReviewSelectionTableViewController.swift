//
//  ReviewSelectionTableViewController.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

protocol ReviewSelectionTableViewDelegate: class {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, difficulty: Difficulty?, category: Category?)
}

class ReviewSelectionTableViewController: UITableViewController {
    
    static let sectionNumber = 2
    
    weak var delegate: ReviewSelectionTableViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectionCell")
        
        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ReviewSelectionTableViewController.sectionNumber
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categories"
        case 1:
            return "Difficulty"
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Category.allCases.count
        case 1:
            return Difficulty.allCases.count
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath)
        
        let title: String
        switch indexPath.section {
        case 0:
            title = Category.allCases[indexPath.row].rawValue
        case 1:
            title = Difficulty.allCases[indexPath.row].rawValue
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var category: Category?
        var difficulty: Difficulty?
        
        switch indexPath.section {
        case 0:
            category = Category.allCases[indexPath.row]
        case 1:
            difficulty = Difficulty.allCases[indexPath.row]
        default:
            fatalError("There should only be \(ReviewSelectionTableViewController.sectionNumber) sections")
        }
        delegate?.tableView(tableView, didSelectRowAt: indexPath, difficulty: difficulty, category: category)
    }
    
    func animateTableViewOut() {
        
    }
    
}
