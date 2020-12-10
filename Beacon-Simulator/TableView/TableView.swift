//
//  TableView.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 05/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

protocol TableViewActionsDelegate {
    func rowTapped(indexPath: IndexPath)
}

class TableView: NSObject {
    
    // MARK: - Properties
    
    private var tableView: UITableView?
    private var tableViewCustomCellName: String = ""
    public var actionsDelegate: TableViewActionsDelegate?
    private var objectList: [Any] = []
    enum customCellType: String {
        case Project = "ProjectTableViewCell"
        case Beacon = "BeaconTableViewCell"
    }
    
    // MARK: - Methods
    
    init(size: CGRect, customCellName: customCellType, cellHeight: CGFloat) {
        super.init()
        
        // Creates the UITableView.
        self.tableView = UITableView(frame: size, style: UITableView.Style.plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        // Registers the custom cell in the UITableView.
        self.tableViewCustomCellName = customCellName.rawValue
        let cellNib: UINib = UINib(nibName: self.tableViewCustomCellName, bundle: nil)
        self.tableView?.register(cellNib, forCellReuseIdentifier: self.tableViewCustomCellName)
        self.tableView?.rowHeight = cellHeight
    }
    
    ///
    /// Sets the data to show on the UITableView.
    ///
    public func setObjectData(objects: [Any]) {
        self.objectList = objects
        self.tableView?.reloadData()
    }
    
    ///
    /// Sends back the TableView's view.
    ///
    public func getTableView() -> UIView? {
        
        // Returns the TableView as a UIView.
        return tableView
    }
}

// MARK: - UITableView Data Source

extension TableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.tableViewCustomCellName {
        case customCellType.Project.rawValue:
            let cell: ProjectTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCustomCellName, for: indexPath) as! ProjectTableViewCell
            cell.displayData(project: self.objectList[indexPath.row] as! Project)
            return cell
        case customCellType.Beacon.rawValue:
            let cell: BeaconTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCustomCellName, for: indexPath) as! BeaconTableViewCell
            cell.selectionStyle = .none
            cell.displayData(beacon: self.objectList[indexPath.row] as! Beacon)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableView Delegate

extension TableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.actionsDelegate {
            tableView.deselectRow(at: indexPath, animated: true)
            delegate.rowTapped(indexPath: indexPath)
        }
    }
}
