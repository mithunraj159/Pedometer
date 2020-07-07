//
//  Cell.swift
//  Pedometer
//
//  Created by Mithun Raj on 06/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadItems(workOutItem: WorkOut) {
        stepsLabel.text = "\(workOutItem.numberOfSteps) Steps on"
        dateLabel.text = "\(workOutItem.startDate ?? "") - \(workOutItem.endDate ?? "")"
    }
    
}
