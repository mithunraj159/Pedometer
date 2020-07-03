//
//  UnitConversion.swift
//  Pedometer
//
//  Created by Mithun Raj on 02/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation

struct UnitConversion {
    
    // MARK:- Conversion Functions
    // convert seconds to hh:mm:ss as a string
    static func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    // convert a pace in meters per second to a string with
    // the metric m/s and the Imperial minutes per mile
    static func paceString(title:String,pace:Double) -> String{
        var minPerMile = 0.0
        let factor = 26.8224 //conversion factor
        if pace != 0 {
            minPerMile = factor / pace
        }
        let minutes = Int(minPerMile)
        let seconds = Int(minPerMile * 60) % 60
        return String(format: "%@: %02.2f m/s \n\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
    }
    
    static func miles(meters:Double)-> Double{
        let mile = 0.000621371192
        return meters * mile
    }
    
}
