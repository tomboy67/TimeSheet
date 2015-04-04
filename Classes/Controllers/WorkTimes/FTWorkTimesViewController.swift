//
//  FTWorkTimesViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTWorkTimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as FTWorkTimesTableViewDayCell;
        
        cell.dayLabel.text = "2日";
        cell.wdayLabel.text = "水";
        
        return cell;
    }
    
}
