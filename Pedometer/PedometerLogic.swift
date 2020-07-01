//
//  PedometerLogic.swift
//  Pedometer
//
//  Created by Mithun Raj on 01/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

struct PedometerLogic {
        
    func startStopButtonUIUpdation(sender: UIButton) {
        if sender.titleLabel?.text == Constants.ButtonTitle.startTitle{
            //Start the pedometer
           //Toggle the UI to on state
            sender.setTitle(Constants.ButtonTitle.stopTitle, for: .normal)
            sender.backgroundColor = Constants.ButtonColors.stopButtonColor
        } else {
           //Stop the pedometer
           //Toggle the UI to off state
            sender.backgroundColor = Constants.ButtonColors.startButtonColor
            sender.setTitle(Constants.ButtonTitle.startTitle, for: .normal)
        }
    }

}
