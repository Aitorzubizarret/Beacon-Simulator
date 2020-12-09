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
    
    let locationManager = CLLocationManager()
    var tableView: TableView?
    var projectList: [Project] = []
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configNavigationBar()
        
        // Ask Location Permission.
        locationManager.requestWhenInUseAuthorization()
        
        self.createDemoProjects()
        
        self.addTableView()
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
        self.present(newProjectVC, animated: true, completion: nil)
    }
    
    ///
    /// Creates demo beacons.
    ///
    private func createDemoProjects() {
        let beacon1: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "1", name: "Beacon 1")
        let beacon2: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "2", name: "Beacon 2")
        let beacon3: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "3", name: "Beacon 3")
        
        let project1: Project = Project(name: "Project 1", beaconList: [beacon1, beacon2])
        let project2: Project = Project(name: "Project 2", beaconList: [beacon3])
        
        self.projectList.append(project1)
        self.projectList.append(project2)
    }
    
    ///
    /// Adds a TableView.
    ///
    private func addTableView() {
        
        // Creates the UITableView
        self.tableView = TableView(size: self.view.bounds, customCellName: TableView.customCellType.Project, cellHeight: 60)
        
        // Check the TableView.
        if let tableView = self.tableView {
            tableView.setObjectData(objects: self.projectList as [Project])
            tableView.actionsDelegate = self
            
            // Check the UIView from the TableView.
            if let view: UIView = tableView.getTableView() {
                self.view.addSubview(view)
            }
        }
    }
}

// MARK: - TableView Actions Delegate

extension MainViewController: TableViewActionsDelegate {
    
    func rowTapped(indexPath: IndexPath) {
        let projectDetailVC: ProjectDetailViewController = ProjectDetailViewController()
        projectDetailVC.project = self.projectList[indexPath.row]
        self.navigationController?.pushViewController(projectDetailVC, animated: true)
    }
}
