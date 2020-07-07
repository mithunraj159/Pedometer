//
//  CoreDataFunctions.swift
//  Pedometer
//
//  Created by Mithun Raj on 03/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataFunctions {
    
    static func addWorkOut(workOutNumberOfSteps: Int, workOutDistance: Double, workOutAveragePace: Double, workOutDuration: Double, workOutStartDate: String, workOutEndDate: String) {
        let workOut = WorkOut(context: PersistentStorage.shared.context)
        workOut.numberOfSteps = Int64(workOutNumberOfSteps)
        workOut.distance = workOutDistance
        workOut.averagePace = workOutAveragePace
        workOut.duration = workOutDuration
        workOut.startDate = workOutStartDate
        workOut.endDate = workOutEndDate
        PersistentStorage.shared.saveContext()
    }
    
    static func fetchWorkOut() -> [WorkOut]? {
        let request: NSFetchRequest<WorkOut> = WorkOut.fetchRequest()
        do {
            let workOutFetchArray = try PersistentStorage.shared.context.fetch(request)
            return workOutFetchArray
        } catch {
            print("Error while fetching from core data")
            return nil
        }
    }
}
