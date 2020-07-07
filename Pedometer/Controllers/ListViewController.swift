//
//  ListViewController.swift
//  Pedometer
//
//  Created by Mithun Raj on 06/07/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var workOutArray = [WorkOut]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        print(currentDate.toString(dateFormat: "dd MMMM yyyy, HH:mm"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadCoreDataValues()
    }
    
    func loadCoreDataValues() {
        if let workOutArray = CoreDataFunctions.fetchWorkOut() {
            self.workOutArray = workOutArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workOutArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableValues.cell, for: indexPath) as? Cell
        cell?.loadItems(workOutItem: workOutArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}

