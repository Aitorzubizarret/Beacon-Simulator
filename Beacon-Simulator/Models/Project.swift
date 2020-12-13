//
//  Project.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 05/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

class Project {
    var id: UUID
    var name: String
    var beaconList: [Beacon]
    
    init(id: UUID, name: String, beaconList: [Beacon]) {
        self.id = id
        self.name = name
        self.beaconList = beaconList
    }
}
