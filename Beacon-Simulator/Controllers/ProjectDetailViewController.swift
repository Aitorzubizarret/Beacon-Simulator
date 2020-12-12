//
//  ProjectDetailViewController.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 05/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {

    // MARK: - Properties
    
    var project: Project?
    var tableView: TableView?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configNavigationBar()
        
        self.addTableView()
    }
    
    ///
    /// Configures the Navigation Bar.
    ///
    private func configNavigationBar() {
        // Title.
        if let theProject = self.project {
            self.title = theProject.name
        }
    }
    
    ///
    /// Adds a TableView.
    ///
    private func addTableView() {
        
        // Creates the UITableView
        self.tableView = TableView(size: self.view.bounds, customCellName: TableView.customCellType.Beacon, cellHeight: 70)
        
        // Check the TableView.
        if let tableView = self.tableView {
            if let project = self.project {
                tableView.setObjectData(objects: project.beaconList as [Beacon])
                tableView.actionsDelegate = self
                
                // Check the UIView from the TableView.
                if let view: UIView = tableView.getTableView() {
                    self.view.addSubview(view)
                }
            }
        }
    }
}

// MARK: - TableView Actions Delegate

extension ProjectDetailViewController: TableViewActionsDelegate {
    
    func rowTapped(indexPath: IndexPath) {
        print("Tapped beacon")
    }
}
