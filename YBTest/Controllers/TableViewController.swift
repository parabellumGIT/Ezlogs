//
//  TableViewController.swift
//  YBTest
//
//  Created by ParaBellum on 11/27/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var model = LatinTableDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.numSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numItems(forSection: section)
    }
    
    /// Returns the title for the requested table `section`.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.title(forSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") as! BasicTableViewCell
        cell.titleLabel.text = model.text(forSection: indexPath.section, item: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

