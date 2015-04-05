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
        
        let headerView = self.tableView.tableHeaderView as UIView!
        
        headerView.frame.size.height = 25
        self.tableView.tableHeaderView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1;
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
    
    /*
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let tableHeaderView = self.tableView.tableHeaderView;
        
        CGRectMake(
            CGFloat(tableHeaderView.frame.origin.x),
            scrollView.contentOffset.y,
            tableHeaderView?.frame.size.width,
            tableHeaderView?.frame.size.height
        )
    }
    */
    
}
