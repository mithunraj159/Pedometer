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

protocol PedometerLogicDelegate {
    func updateUI(numberOfSteps: Int, distance: Double, averagePace: Double, pace: Double, timeElapsed: TimeInterval)
}

class PedometerLogic {
    
    var timeElapsed: TimeInterval = 0.0
    
    var numberOfSteps: Int! = 0
    var distance: Double! = 0.0
    var averagePace: Double! = 0.0
    var pace: Double! = 0.0
    
    var pedometer = CMPedometer()
    var timerFunctions = TimerFunctions()
    
    var delegate: PedometerLogicDelegate?
    
    func startStopButtonUIUpdation(sender: UIButton) {
        if sender.titleLabel?.text == Constants.ButtonTitle.startTitle{
            //Start the pedometer
            //Toggle the UI to on state
            timerFunctions.delegate = self
            timerFunctions.startTimer()
            pedoMeterStartUpdates()
            sender.setTitle(Constants.ButtonTitle.stopTitle, for: .normal)
            sender.backgroundColor = Constants.ButtonColors.stopButtonColor
        } else {
            //Stop the pedometer
            //Toggle the UI to off state
            pedometer.stopUpdates()
            timerFunctions.stopTimer()
            sender.backgroundColor = Constants.ButtonColors.startButtonColor
            sender.setTitle(Constants.ButtonTitle.startTitle, for: .normal)
        }
    }
    
    func triggerViewControllerDelegate() {
        timeElapsed += 1.0
        delegate?.updateUI(numberOfSteps: self.numberOfSteps, distance: self.distance, averagePace: self.averagePace, pace: self.pace, timeElapsed: self.timeElapsed)
    }
    
    
    func pedoMeterStartUpdates() {
        pedometer = CMPedometer()
        pedometer.startUpdates(from: Date()) { (pedometerData, error) in
            if let pedData = pedometerData {
                self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
                //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                if let distance = pedData.distance{
                    self.distance = Double(truncating: distance)
                }
                if let averageActivePace = pedData.averageActivePace {
                    self.averagePace = Double(truncating: averageActivePace)
                }
                if let currentPace = pedData.currentPace {
                    self.pace = Double(truncating: currentPace)
                }
            } else {
                self.numberOfSteps = nil
            }
        }
    }
    
}

extension PedometerLogic: TimerFunctionsDelegate {
    func triggerTheDelegateMethod() {
        triggerViewControllerDelegate()
    }
    
    
}

