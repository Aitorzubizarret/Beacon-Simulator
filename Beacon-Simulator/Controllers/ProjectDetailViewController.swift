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
    
    var projectId: UUID?
    var project: Project? {
        didSet {
            self.tableView?.setObjectData(objects: project!.beaconList)
        }
    }
    var projectsViewModel: ProjectsViewModel?
    var tableView: TableView?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProjectFromViewModel()
        
        self.configNavigationBar()
        
        self.addTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getProjectFromViewModel()
    }
    
    ///
    /// Gets the Project object from the View Model.
    ///
    private func getProjectFromViewModel() {
        guard let projectViewModel = self.projectsViewModel else { return }
        
        guard let projectId = self.projectId else { return }
        
        if let project = projectViewModel.getProject(projectId: projectId) {
            self.project = project
        }
    }
    
    ///
    /// Configures the Navigation Bar.
    ///
    private func configNavigationBar() {
        
        // Project Title.
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
            tableView.actionsDelegate = self
            
            // Check the UIView from the TableView.
            if let view: UIView = tableView.getTableView() {
                self.view.addSubview(view)
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
