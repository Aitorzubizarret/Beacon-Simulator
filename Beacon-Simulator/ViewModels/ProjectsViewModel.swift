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
        // Init the empty array.
        self.projectList = []
    }
    
    ///
    /// Adds a new project to the data source.
    ///
    public func addProject(newProject: Project) {
        self.projectList?.append(newProject)
    }
    
    ///
    /// Searches a project in the data source by a projectId and if found, returns it.
    ///
    public func getProject(projectId: UUID) -> Project? {
        var foundProject: Project?
        
        if let projects = self.projectList {
            if let project = projects.first(where: { $0.id == projectId }) {
                foundProject = project
            }
        }
        return foundProject
    }
    
    ///
    /// Adds a new Beacon to a Project and saves in data source.
    ///
    public func addBeaconToProject(projectId: UUID, beacon: Beacon) {
        
        if let projects = self.projectList {
            for i in 0 ..< projects.count {
                if projects[i].id == projectId {
                    projects[i].beaconList.append(beacon)
                }
            }
        }
    }
}
