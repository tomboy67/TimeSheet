//
//  FTTopNavigationController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import UIColor_FlatColors

class FTTopNavigationController: UINavigationController {

    var bottomBorderLayer : CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBorderLayer.backgroundColor = UIColor.flatSunFlowerColor().CGColor
        self.navigationBar.layer.addSublayer(bottomBorderLayer)
        self.updateBottomBorderInNavigationBar()
        
        self.navigationBar.tintColor = UIColor.flatSunFlowerColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateBottomBorderInNavigationBar()
    }

    func updateBottomBorderInNavigationBar() {
        bottomBorderLayer.frame = CGRectMake(0.0, self.navigationBar.frame.size.height, self.navigationBar.frame.size.width, 1.0)
    }

}
