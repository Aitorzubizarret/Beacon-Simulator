//
//  ProjectsViewModel.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta Perez on 10/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

class ProjectsViewModel {
    
    // MARK: - Properties
    
    // Binding
    var binding = { () -> () in }
    
    // Data Source
    var projectList: [Project]? {
        didSet {
            self.binding()
        }
    }
    
    // MARK: - Methods
    
    init() {
        self.getDemoProjects()
    }
    
    ///
    /// Creates demo projects and adds them to the data source.
    ///
    private func getDemoProjects() {
        let beacon1: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "1", name: "Beacon 1")
        let beacon2: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "2", name: "Beacon 2")
        let beacon3: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "3", name: "Beacon 3")
        let beacon4: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "4", name: "Beacon 4")
        let beacon5: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "5", name: "Beacon 5")
        let beacon6: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "6", name: "Beacon 6")
        let beacon7: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "7", name: "Beacon 7")
        let beacon8: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "8", name: "Beacon 8")
        let beacon9: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "9", name: "Beacon 9")
        let beacon10: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "10", name: "Beacon 10")
        let beacon11: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "11", name: "Beacon 11")
        let beacon12: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "12", name: "Beacon 12")
        let beacon13: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "13", name: "Beacon 13")
        let beacon14: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "14", name: "Beacon 14")
        let beacon15: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "15", name: "Beacon 15")
        let beacon16: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "16", name: "Beacon 16")
        let beacon17: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "17", name: "Beacon 17")
        let beacon18: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "18", name: "Beacon 18")
        let beacon19: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "19", name: "Beacon 19")
        let beacon20: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "20", name: "Beacon 20")
        let beacon21: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "21", name: "Beacon 21")
        let beacon22: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "22", name: "Beacon 22")
        let beacon23: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "23", name: "Beacon 23")
        let beacon24: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "24", name: "Beacon 24")
        let beacon25: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "25", name: "Beacon 25")
        let beacon26: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "26", name: "Beacon 26")
        let beacon27: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "27", name: "Beacon 27")
        let beacon28: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "28", name: "Beacon 28")
        let beacon29: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "29", name: "Beacon 29")
        let beacon30: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "30", name: "Beacon 30")
        let beacon31: Beacon = Beacon(uuid: "00000000-0000-0000-0000-00000000aaaa", major: "1", minor: "31", name: "Beacon 31")
        
        let project1: Project = Project(id: UUID(), name: "Project 1", beaconList: [beacon1, beacon2, beacon3, beacon4, beacon5, beacon6, beacon7, beacon8, beacon9, beacon10, beacon11, beacon12, beacon13, beacon14, beacon15, beacon16])
        let project2: Project = Project(id: UUID(), name: "Project 2", beaconList: [beacon17, beacon18, beacon19, beacon20, beacon21, beacon22, beacon23, beacon24, beacon25, beacon26, beacon27, beacon28, beacon29, beacon30, beacon31])
        
        self.projectList = [project1, project2]
    }
    
    ///
    /// Adds a new project to the data source.
    ///
    public func addProject(newProject: Project) {
        self.projectList?.append(newProject)
    }
}
