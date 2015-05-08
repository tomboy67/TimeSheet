//
//  FTIntrosPageViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/19.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTIntrosPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    // MARK: - Variables
    
    var _modelController : FTIntrosModelViewController? = nil
    
    /// データモデルを返すクラスを返す
    var modelController : FTIntrosModelViewController {
        if _modelController == nil {
            _modelController = FTIntrosModelViewController()
        }
        return _modelController!
    }
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self.modelController
        
        let startingViewController: FTIntrosPageDataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        self.addChildViewController(startingViewController)
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
