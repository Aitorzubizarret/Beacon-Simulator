//
//  ProjectTableViewCell.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 05/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    // MARK: - UI
    
    @IBOutlet weak var title: UILabel!
    
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
    public func displayData(project: Project) {
        self.title.text = project.name
    }
    
}
