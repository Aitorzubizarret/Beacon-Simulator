//
//  BeaconTableViewCell.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 05/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BeaconTableViewCell: UITableViewCell {

    // MARK: - UI
    
    @IBOutlet weak var uuidTitle: UILabel!
    @IBOutlet weak var uuidValue: UILabel!
    @IBOutlet weak var majorTitle: UILabel!
    @IBOutlet weak var majorValue: UILabel!
    @IBOutlet weak var minorTitle: UILabel!
    @IBOutlet weak var minorValue: UILabel!
    @IBOutlet weak var broadcastSwitch: UISwitch!
    @IBAction func broadcastSwitchTapped(_ sender: Any) {
        self.broadcastSwitchTappedFunc()
    }
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var region: CLBeaconRegion?
    var _peripheralManager: CBPeripheralManager?
    var peripheralManager: CBPeripheralManager {
        if _peripheralManager == nil {
            _peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        }
        return _peripheralManager!
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    ///
    /// Displays the data of the received object.
    ///
    public func displayData(beacon: Beacon) {
        
        self.uuidTitle.font = UIFont(name: "Arial", size: 12)
        self.uuidValue.font = UIFont(name: "Arial", size: 12)
        self.majorTitle.font = UIFont(name: "Arial", size: 12)
        self.majorValue.font = UIFont(name: "Arial", size: 12)
        self.minorTitle.font = UIFont(name: "Arial", size: 12)
        self.minorValue.font = UIFont(name: "Arial", size: 12)
        
        self.uuidTitle.text = "UUID : "
        self.uuidValue.text = beacon.uuid
        self.majorTitle.text = "Major : "
        self.majorValue.text = beacon.major
        self.minorTitle.text = "Minor : "
        self.minorValue.text = beacon.minor
        
        self.broadcastSwitch.isOn = false
    }
    
    ///
    /// Method that runs after the user tapped the Switch.
    ///
    private func broadcastSwitchTappedFunc() {
        if self.broadcastSwitch.isOn {
            self.broadcastSwitch.isOn = false
            self.stopTransmitting()
        } else {
            self.broadcastSwitch.isOn = true
            self.startTransmitting()
        }
    }
    
    ///
    /// Start transmitting the beacon signal.
    ///
    func startTransmitting() {
        
        // Get values from textfields.
        let uuidString: String = self.uuidValue.text ?? ""
        let majorString: String = self.majorValue.text ?? ""
        let minorString: String = self.minorValue.text ?? ""
        
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

// MARK: - Extension Core Bluetooth

extension BeaconTableViewCell: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            if self.broadcastSwitch.isOn {
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
