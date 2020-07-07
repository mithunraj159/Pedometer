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
    func updateCoredataDetails()
}

class PedometerLogic {
    
    var timeElapsed: TimeInterval = 0.0
    
    var numberOfSteps: Int! = 0
    var distance: Double! = 0.0
    var averagePace: Double! = 0.0
    var pace: Double! = 0.0
    var startDate: String = ""
    var endDate: String = ""
    
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
            startDate = dateToStringConversion()
            sender.setTitle(Constants.ButtonTitle.stopTitle, for: .normal)
            sender.backgroundColor = Constants.ButtonColors.stopButtonColor
        } else {
            //Stop the pedometer
            //Toggle the UI to off state
            pedometer.stopUpdates()
            timerFunctions.stopTimer()
            endDate = dateToStringConversion()
            CoreDataFunctions.addWorkOut(workOutNumberOfSteps: self.numberOfSteps, workOutDistance: self.distance, workOutAveragePace: self.averagePace, workOutDuration: self.timeElapsed, workOutStartDate: self.startDate, workOutEndDate: self.endDate)
            sender.backgroundColor = Constants.ButtonColors.startButtonColor
            sender.setTitle(Constants.ButtonTitle.startTitle, for: .normal)
        }
    }
    
    func dateToStringConversion() -> String {
        let currentDate = Date()
        return (currentDate.toString(dateFormat: "dd MMMM yyyy, HH:mm"))
    }
    
    func triggerViewControllerDelegate() {
        timeElapsed += 1.0
        delegate?.updateUI(numberOfSteps: self.numberOfSteps, distance: self.distance, averagePace: self.averagePace, pace: self.pace, timeElapsed: self.timeElapsed)
    }
    
    func updateCoreDataDelegate() {
        delegate?.updateCoredataDetails()
    }
    
    
    func pedoMeterStartUpdates() {
        pedometer = CMPedometer()
        pedometer.startUpdates(from: Date()) { (pedometerData, error) in
            if let pedData = pedometerData {
                
                self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
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
                self.numberOfSteps = 0
            }
        }
    }
    
    func getEarlierUpdates() {
        if CMPedometer.isStepCountingAvailable() {
            print("Step counting is available...")
            let calendar = Calendar.current
            var toDate = Date()
            var fromDate = calendar.startOfDay(for: toDate)
            fromDate = calendar.date(byAdding: .hour, value: -24, to: fromDate)!
            toDate = calendar.date(byAdding: .hour, value: 2, to: toDate)!
            print("From date = \(fromDate)")
            print("To date = \(toDate)")

            pedometer.queryPedometerData(from: fromDate, to: toDate) { (data, error) in
                print("Handler (data):")
                print(data!)
                guard let activityData = data, error == nil else {
                    print("There was an error getting the data: \(error!)")
                    return
                }
                DispatchQueue.main.async {
                    print("Steps and distance: \(activityData.numberOfSteps) \(activityData.distance ?? -1)")
                }
            }
        }
        
    }
    
}

extension PedometerLogic: TimerFunctionsDelegate {
    func triggerTheDelegateMethod() {
        triggerViewControllerDelegate()
        updateCoreDataDelegate()
        
    }
    
    
}

