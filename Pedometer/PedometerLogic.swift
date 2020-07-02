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
    
    var timer = Timer()
    let timerInterval = 1.0
    var timeElapsed: TimeInterval = 0.0
    
    var numberOfSteps: Int! = 0
    var distance: Double! = 0.0
    var averagePace: Double! = 0.0
    var pace: Double! = 0.0
    
    var pedometer = CMPedometer()
    
    var delegate: PedometerLogicDelegate?
        
    func startStopButtonUIUpdation(sender: UIButton) {
        if sender.titleLabel?.text == Constants.ButtonTitle.startTitle{
            //Start the pedometer
           //Toggle the UI to on state
            startTimer()
            pedoMeterStartUpdates()
            sender.setTitle(Constants.ButtonTitle.stopTitle, for: .normal)
            sender.backgroundColor = Constants.ButtonColors.stopButtonColor
        } else {
           //Stop the pedometer
           //Toggle the UI to off state
            pedometer.stopUpdates()
            stopTimer()
            sender.backgroundColor = Constants.ButtonColors.startButtonColor
            sender.setTitle(Constants.ButtonTitle.startTitle, for: .normal)
        }
    }
    
    // MARK:- Conversion Functions
    // convert seconds to hh:mm:ss as a string
        func timeIntervalFormat(interval:TimeInterval)-> String{
            var seconds = Int(interval + 0.5) //round up seconds
            let hours = seconds / 3600
            let minutes = (seconds / 60) % 60
            seconds = seconds % 60
            return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
        }
        // convert a pace in meters per second to a string with
        // the metric m/s and the Imperial minutes per mile
        func paceString(title:String,pace:Double) -> String{
            var minPerMile = 0.0
            let factor = 26.8224 //conversion factor
            if pace != 0 {
                minPerMile = factor / pace
            }
            let minutes = Int(minPerMile)
            let seconds = Int(minPerMile * 60) % 60
            return String(format: "%@: %02.2f m/s \n\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
        }
         
    func computedAvgPace()-> Double {
        if let distance = self.distance{
            pace = distance / timeElapsed
            return pace
        } else {
            return 0.0
        }
    }
     
    func miles(meters:Double)-> Double{
            let mile = 0.000621371192
            return meters * mile
        }
    
    //MARK: - timer functions
    func startTimer(){
           if timer.isValid { timer.invalidate() }
           timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
       }
        
       func stopTimer(){
           timer.invalidate()
           //displayPedometerData()
        timeElapsed += 1.0
        delegate?.updateUI(numberOfSteps: self.numberOfSteps, distance: self.distance, averagePace: self.averagePace, pace: self.pace, timeElapsed: self.timeElapsed)
       }
        
     @objc func timerAction(timer:Timer){
           //displayPedometerData()
        timeElapsed += 1.0
        delegate?.updateUI(numberOfSteps: self.numberOfSteps, distance: self.distance, averagePace: self.averagePace, pace: self.pace, timeElapsed: self.timeElapsed)
       }
       
       /*func displayPedometerData(){
           timeElapsed += 1.0
           timeLabel.text = "On: " + timeIntervalFormat(interval: timeElapsed)
           //Number of steps
           if let numberOfSteps = self.numberOfSteps{
               stepsLabel.text = String(format:"Steps: %i",numberOfSteps)
           }
            
           //distance
           if let distance = self.distance{
               distanceLabel.text = String(format:"Distance: %02.02f meters,\n %02.02f mi",distance,miles(meters: distance))
           } else {
               distanceLabel.text = "Distance: N/A"
           }
            
           //average pace
           if let averagePace = self.averagePace{
               averagePaceLabel.text = paceString(title: "Avg Pace", pace: averagePace)
           } else {
               averagePaceLabel.text =  paceString(title: "Avg Comp Pace", pace: computedAvgPace())
           }
            
           //pace
           if let pace = self.pace {
               paceLabel.text = paceString(title: "Pace:", pace: pace)
           } else {
               paceLabel.text =  paceString(title: "Avg Comp Pace", pace: computedAvgPace())
           }
       }*/
    
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
