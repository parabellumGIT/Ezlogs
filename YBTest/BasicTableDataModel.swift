//
//  BasicTableDataModelProtocol.swift
//  YBTest
//
//  Created by ParaBellum on 11/27/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//
/// Conforming types provide data needed to populate a table view with basic data.
protocol BasicTableDataModel {
    
    /// Returns the number of sections in the table.
    var numSections: Int { get }
    
    /// Returns the number of items or rows in the given `section` of the table.
    func numItems(forSection section: Int) -> Int
    
    /// Returns the `section` title, or `nil` if there is no section title.
    func title(forSection section: Int) -> String?
    
    /// Returns the text for the `item` in `section`, or `nil` if there is no text for that item.
    func text(forSection section: Int, item: Int) -> String?
}
