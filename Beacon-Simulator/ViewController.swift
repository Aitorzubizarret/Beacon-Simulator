//
//  ViewController.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 27/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var uuidTextfield: UITextField!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorTextfield: UITextField!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var minorTextfield: UITextField!
    @IBOutlet weak var startStopBtn: UIButton!
    @IBAction func startStopBtnPressed(_ sender: Any) {
        if self.isOn {
            self.stop()
        } else {
            self.start()
        }
    }
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var isOn: Bool = false
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
        
        self.configureUI()
        
        // Ask Location Permission.
        locationManager.requestWhenInUseAuthorization()
    }
    
    ///
    /// Configures the UI.
    ///
    private func configureUI() {
        // Title.
        self.titleLabel.text = "Beacon Simulator"
        
        // Labels.
        self.uuidLabel.text = "UUID"
        self.majorLabel.text = "Major"
        self.minorLabel.text = "Minor"
        
        // Textfields.
        self.uuidTextfield.text = "00000000-0000-0000-0000-00000000aaaa"
        self.majorTextfield.text = "1"
        self.minorTextfield.text = "1"
        
        // Button.
        if self.isOn {
            self.startStopBtn.setTitle("Stop", for: .normal)
        } else {
            self.startStopBtn.setTitle("Start", for: .normal)
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
}

extension ViewController: CBPeripheralManagerDelegate {
    
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
