//
//  NewBeaconViewController.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta Perez on 12/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class NewBeaconViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var UUIDTextfield: UITextField!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var minorTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.createNewBeacon()
    }
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.exitViewController()
    }
    
    
    // MARK: - Properties
    
    var projectsViewModel: ProjectsViewModel?
    var projectId: UUID?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }
    
    ///
    /// Configures the UI elements.
    ///
    private func configureUI() {
        
        // Labels text.
        self.titleLabel.text = "Beacon Name"
        self.UUIDLabel.text = "UUID"
        self.majorLabel.text = "Major"
        self.minorLabel.text = "Minor"
        self.saveButton.setTitle("Save new Beacon", for: .normal)
        self.exitButton.setTitle("Exit", for: .normal)
        
        // Keyboard types.
        self.titleTextfield.keyboardType = .default
        self.UUIDTextfield.keyboardType = .default
        self.majorTextfield.keyboardType = .decimalPad
        self.minorTextfield.keyboardType = .decimalPad
        
        // Gesture Recognizer to hide the keyboard.
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
    /// Creates a new Beacon.
    ///
    private func createNewBeacon() {
        let newBeacon: Beacon = Beacon(uuid: "0000", major: "1", minor: "1", name: "Demo")
        
        guard let projectId = self.projectId else { return }
        
        guard let projectsViewModel = self.projectsViewModel else { return }
        
        projectsViewModel.addBeaconToProject(projectId: projectId, beacon: newBeacon)
        
        self.exitViewController()
    }
    
    ///
    /// Dismisses the View Controller without saving.
    ///
    private func exitViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
