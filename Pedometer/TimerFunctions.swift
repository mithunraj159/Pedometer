//
//  TimerFunctions.swift
//  Pedometer
//
//  Created by Mithun Raj on 02/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation

protocol TimerFunctionsDelegate {
    func triggerTheDelegateMethod()
}

class TimerFunctions {
    var timer = Timer()
    let timerInterval = 1.0
    
    var delegate: TimerFunctionsDelegate?
    
    func startTimer() {
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        delegate?.triggerTheDelegateMethod()
    }
    
    @objc  func timerAction(timer:Timer) {
        delegate?.triggerTheDelegateMethod()
    }
}
