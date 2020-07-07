//
//  DateExtension.swift
//  Pedometer
//
//  Created by Mithun Raj on 06/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var startOfDay : Date {
         let calendar = Calendar.current
         let unitFlags = Set<Calendar.Component>([.year, .month, .day])
         let components = calendar.dateComponents(unitFlags, from: self)
         return calendar.date(from: components)!
    }

     var endOfDay : Date {
         var components = DateComponents()
         components.day = 1
         let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
         return (date?.addingTimeInterval(-1))!
     }

}
