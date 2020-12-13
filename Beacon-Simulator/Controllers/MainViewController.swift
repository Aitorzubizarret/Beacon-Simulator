//
//  MainViewController.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 01/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var projectsViewModel: ProjectsViewModel = ProjectsViewModel()
    let locationManager = CLLocationManager()
    var tableView: TableView?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configNavigationBar()
        
        // Ask Location Permission.
        locationManager.requestWhenInUseAuthorization()
        
        self.bind()
        
        self.addTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateTableViewData()
    }
    
    ///
    /// Gets new data from the View Model.
    ///
    private func bind() {
        self.projectsViewModel.binding = {
            self.updateTableViewData()
        }
    }
    
    ///
    /// Gets data from the View Model and sends it to the Table View.
    ///
    private func updateTableViewData() {
        if let data = self.projectsViewModel.projectList {
            self.tableView?.setObjectData(objects: data)
        }
    }
    
    ///
    /// Configures the Navigation Bar.
    ///
    private func configNavigationBar() {
        
        // Sets a title.
        self.title = "Projects"
        
        // Adds a button.
        let addProject = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProjectTapped))
        navigationItem.rightBarButtonItem = addProject
    }
    
    ///
    /// Shows the view controller to create a new Project.
    ///
    @objc func addProjectTapped() {
        let newProjectVC: NewProjectViewController = NewProjectViewController()
        newProjectVC.projectsViewModel = self.projectsViewModel
        self.present(newProjectVC, animated: true, completion: nil)
    }
    
    ///
    /// Adds a TableView.
    ///
    private func addTableView() {
        
        // Creates the UITableView
        self.tableView = TableView(size: self.view.bounds, customCellName: TableView.customCellType.Project, cellHeight: 60)
        
        // Check the TableView.
        if let tableView = self.tableView {
            if let projectList = self.projectsViewModel.projectList {
                tableView.setObjectData(objects: projectList as [Project])
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

extension MainViewController: TableViewActionsDelegate {
    
    func rowTapped(indexPath: IndexPath) {
        let projectDetailVC: ProjectDetailViewController = ProjectDetailViewController()
        if let projectList = self.projectsViewModel.projectList {
            projectDetailVC.project = projectList[indexPath.row]
            self.navigationController?.pushViewController(projectDetailVC, animated: true)
        }
    }
}
