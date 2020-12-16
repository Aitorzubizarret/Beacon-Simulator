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
        let (valuesCorrect, uuid, major, minor) = self.checkValues()
        
        if valuesCorrect,
           let uuid = uuid,
           let major = major,
           let minor = minor {
            
            let newBeacon: Beacon = Beacon(uuid: uuid, major: major, minor: minor, name: self.titleTextfield.text!)
            
            guard let projectId = self.projectId else { return }
            
            guard let projectsViewModel = self.projectsViewModel else { return }
            
            projectsViewModel.addBeaconToProject(projectId: projectId, beacon: newBeacon)
            
            self.exitViewController()
        } else {
            let alertMessage: UIAlertController = UIAlertController(title: "Alert", message: "The values are not correct.", preferredStyle: .alert)
            let OKButton: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(OKButton)
            
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    ///
    /// Dismisses the View Controller without saving.
    ///
    private func exitViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    ///
    /// Checks the values from the Textfields before creating the Beacon.
    ///
    private func checkValues() -> (Bool, UUID?, UInt16?, UInt16?) {
        guard let UUIDText: String = self.UUIDTextfield.text,
              let MAJORText: String = self.majorTextfield.text,
              let MINORText: String = self.minorTextfield.text,
              let _: String = self.titleTextfield.text
        else { return (false, nil, nil, nil) }
        
        let UUIDValue: UUID? = UUID(uuidString: UUIDText)
        let MAJORValue: UInt16? = UInt16(MAJORText)
        let MINORValue: UInt16? = UInt16(MINORText)
        
        if let uuid = UUIDValue, let major = MAJORValue, let minor = MINORValue {
            return (true, uuid, major, minor)
        }
        
        return (false, nil, nil, nil)
    }
}
