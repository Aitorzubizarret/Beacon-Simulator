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

    // MARK: - UI
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var uuidTextfield: UITextField!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var minorTextfield: UITextField!
    @IBOutlet weak var startStopBtn: UIButton!
    @IBAction func startStopBtnTapped(_ sender: Any) {
        self.startStopButtonFunction()
    }
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var isOn: Bool = false {
        didSet {
            if isOn {
                self.uuidTextfield.isEnabled = false
                self.majorTextfield.isEnabled = false
                self.minorTextfield.isEnabled = false
            } else {
                self.uuidTextfield.isEnabled = true
                self.majorTextfield.isEnabled = true
                self.minorTextfield.isEnabled = true
            }
        }
    }
    var region: CLBeaconRegion?
    var _peripheralManager: CBPeripheralManager?
    var peripheralManager: CBPeripheralManager {
        if _peripheralManager == nil {
            _peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        }
        return _peripheralManager!
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar title.
        self.title = "Beacon Simulator"
        
        // Ask Location Permission.
        locationManager.requestWhenInUseAuthorization()
        
        self.configureUI()
    }
    
    ///
    /// Configures the UI.
    ///
    private func configureUI() {

        // Labels.
        self.uuidLabel.text = "UUID"
        self.majorLabel.text = "Major"
        self.minorLabel.text = "Minor"

        // Textfields.
        self.uuidTextfield.text = "00000000-0000-0000-0000-00000000aaaa"
        self.majorTextfield.text = "1"
        self.minorTextfield.text = "1"
        
        // Tap Gesture Recognizer to call a method to dismiss the keyboard.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Button.
        if self.isOn {
            self.startStopBtn.setTitle("Stop", for: .normal)
        } else {
            self.startStopBtn.setTitle("Start", for: .normal)
        }
    }
    
    ///
    /// Start / Stop button tapped.
    ///
    private func startStopButtonFunction() {
        if self.isOn {
            self.stop()
        } else {
            self.start()
        }
    }
    
    ///
    /// Start Button Pressed.
    ///
    func start() {
        self.isOn = true
        
        if self.isOn {
            self.startStopBtn.setTitle("Stop", for: .normal)
        } else {
            self.startStopBtn.setTitle("Start", for: .normal)
        }
            
        self.startTransmitting()
    }
        
    ///
    /// Stop Button Pressed.
    ///
    func stop() {
        self.isOn = false
            
        if self.isOn {
            self.startStopBtn.setTitle("Stop", for: .normal)
        } else {
            self.startStopBtn.setTitle("Start", for: .normal)
        }
            
        self.stopTransmitting()
    }
    
    ///
    /// Start transmitting the beacon signal.
    ///
    func startTransmitting() {
        
        // get values from textfields.
        let uuidString: String = self.uuidTextfield.text ?? ""
        let majorString: String = self.majorTextfield.text ?? ""
        let minorString: String = self.minorTextfield.text ?? ""
        
        // Create the beacon region.
        let proximityUUID = UUID(uuidString: uuidString)
        let major: CLBeaconMajorValue = UInt16(majorString) ?? 1
        let minor: CLBeaconMinorValue = UInt16(minorString) ?? 1
        let beaconID = "BeaconSimulator"
        
        self.region = CLBeaconRegion(proximityUUID: proximityUUID!, major: major, minor: minor, identifier: beaconID)
        let peripheralData = (region?.peripheralData(withMeasuredPower: nil))!

        self.peripheralManager.startAdvertising(((peripheralData as NSDictionary) as! [String: Any]))
    }
    
    ///
    /// Stop transmitting the beacon signal.
    ///
    func stopTransmitting() {
        self.peripheralManager.stopAdvertising()
    }
    
    ///
    /// Dismisses the keyboard.
    ///
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

// MARK: - Extension Core Bluetooth

extension MainViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            if self.isOn {
                self.startTransmitting()
            } else {
                self.stopTransmitting()
            }
        case .poweredOff:
            print("Bluetooth is OFF")
        case .resetting:
            print("Bluetooth is RESETTING")
        case .unauthorized:
            print("Bluetooth is UNAUTHORIZED")
        case .unknown:
            print("Bluetooth is UNKNOWN")
        case .unsupported:
            print("Bluetooth is UNSUPPORTED")
        @unknown default:
            print("UNKNOWN")
        }
    }
}
