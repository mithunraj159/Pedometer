//
//  ViewController.swift
//  Pedometer
//
//  Created by Mithun Raj on 30/06/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var pedometerLogic = PedometerLogic()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialValue()
    }
    
    @IBAction func didTapStartStopButtonAction(_ sender: UIButton) {
        pedometerLogic.delegate = self
        pedometerLogic.startStopButtonUIUpdation(sender: sender)
    }
}

extension ViewController {
    
    func initialValue() {
        stepsLabel.text = "Steps: \(Constants.GeneralKeywords.notAvailable)"
        distanceLabel.text = "Distance: \(Constants.GeneralKeywords.notAvailable)"
        averagePaceLabel.text =  "Average Pace: \(Constants.GeneralKeywords.notAvailable)"
        paceLabel.text =  "Pace: \(Constants.GeneralKeywords.notAvailable)"

    }
    
    func displayPedometerData(receivedNumberOfSteps: Int, receivedDistance: Double, receivedAveragePace: Double, receivePace: Double, receivedTimeElapsed: TimeInterval){
        timeLabel.text = pedometerLogic.timeIntervalFormat(interval: receivedTimeElapsed)
        //Number of steps
            stepsLabel.text = String(format:"Steps : %i",receivedNumberOfSteps)
         
        //distance
        distanceLabel.text = String(format:"Distance: %02.02f meters,\n %02.02f mi",receivedDistance,pedometerLogic.miles(meters: receivedDistance))
         
        //average pace
        averagePaceLabel.text = pedometerLogic.paceString(title: "Avg Pace", pace: receivedAveragePace)
         
        //pace
        paceLabel.text = pedometerLogic.paceString(title: "Pace:", pace: receivePace)
        
    }
}

extension ViewController: PedometerLogicDelegate {
    func updateUI(numberOfSteps: Int, distance: Double, averagePace: Double, pace: Double, timeElapsed: TimeInterval) {
        displayPedometerData(receivedNumberOfSteps: numberOfSteps, receivedDistance: distance, receivedAveragePace: averagePace, receivePace: pace, receivedTimeElapsed: timeElapsed)
    }
    
}

