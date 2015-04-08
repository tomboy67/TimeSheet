//
//  FTIntrosStartViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/09.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import Surfboard

class FTIntrosStartViewController: UIViewController, SRFSurfboardDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let surfboard = segue.destinationViewController as SRFSurfboardViewController
        
        let path : String = NSBundle.mainBundle().pathForResource("panels", ofType: "json")!
        let panels : Array = SRFSurfboardViewController .panelsFromConfigurationAtPath(path)
        println(panels)
        surfboard.setPanels(panels)
        surfboard.delegate = self;
        
        surfboard.backgroundColor = self.view.backgroundColor
    }
    
    // MARK: - SRFSurfboardDelegate
    
    func surfboard(surfboard: SRFSurfboardViewController!, didTapButtonAtIndexPath indexPath: NSIndexPath!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            let storyboard : UIStoryboard = UIStoryboard(name: "Dashboards", bundle: NSBundle.mainBundle())
            self.presentViewController(storyboard.instantiateInitialViewController() as UIViewController, animated: true , completion: { () -> Void in
                println("intro finished")
            })
        })
    }
}
