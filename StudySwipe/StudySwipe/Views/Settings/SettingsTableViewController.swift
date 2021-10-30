//
//  SettingsTableViewController.swift
//  StudySwipe
//
//  Created by Benjamin Hakes on 7/2/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

protocol SettingsTableViewDelegate: AnyObject {
    func darkModeDidChange()
}

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(DMCTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(DarkModeTableViewCell.self, forCellReuseIdentifier: darkCellID)
        
        setUpTheming()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DMCView()
        view.translatesAutoresizingMaskIntoConstraints = true
       
        let label = UILabel.label(for: .header2)
        view.addSubview(label)
        
        switch section {
        case 0:
            label.text = "Display"
        default:
            label.text = "This should not be a section yet."
        }
        
        label.constrainToSuperView(view, bottom: 8, leading: 20)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        default:
            return 40
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: darkCellID, for: indexPath) as? DarkModeTableViewCell else { fatalError("Could not dequeue cell as DarkModeCellDelegate")}
            cell.delegate = self
            cell.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            cell.textLabel?.text = "This should not be a section yet."
            cell.selectionStyle = .none
            
            return cell
        }

        // Configure the cell...
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: darkCellID, for: indexPath) as? DarkModeTableViewCell {
            cell.darkModeSwitchChanged()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - IBOutlets
    
    
    // MARK: - Properties
    let cellID = "cellID"
    let darkCellID = "darkCellID"
    weak var delegate: SettingsTableViewDelegate?

}

extension SettingsTableViewController: DarkModeCellDelegate {
    func darkModeDidChange() {
        self.reloadInputViews()
        self.tableView.reloadData()
        delegate?.darkModeDidChange()
    }
    
    
}

extension SettingsTableViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        
        self.view.backgroundColor = theme.backgroundColor
        
    }
}
