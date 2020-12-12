//
//  NewProjectViewController.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta Perez on 09/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var projectNameTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.createNewProject()
    }
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.exitViewController()
    }
    
    
    // MARK: - Properties
    
    var projectsViewModel: ProjectsViewModel?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }
    
    ///
    /// Configures the UI elements.
    ///
    private func configureUI() {
        self.titleLabel.text = "Project Name"
        self.saveButton.setTitle("Save new Project", for: UIControl.State.normal)
        self.exitButton.setTitle("Exit", for: UIControl.State.normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    ///
    /// Hides the keyboard.
    ///
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    ///
    /// Creates a new Project.
    ///
    private func createNewProject() {
        if self.projectNameTextfield.text != "" {
            if let projectName: String = self.projectNameTextfield.text {
                let newProject: Project = Project(id: UUID(), name: projectName, beaconList: [])
                self.projectsViewModel?.addProject(newProject: newProject)
                
                self.hideKeyboard()
                
                self.exitViewController()
            }
        }
    }
    
    ///
    /// Dismisses the View Controller without saving.
    ///
    private func exitViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
