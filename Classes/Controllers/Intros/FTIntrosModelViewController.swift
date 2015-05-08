//
//  FTIntrosModelViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/19.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTIntrosModelViewController: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let pageIdentifiers : Array<String> = [
        "FTIntrosWelcomeViewController",
        "FTIntrosInputInitialDataViewController",
        "FTIntrosCompleteViewController"
    ]

    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! FTIntrosPageDataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! FTIntrosPageDataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageIdentifiers.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func indexOfViewController(viewController: FTIntrosPageDataViewController) -> Int {
        return viewController.pageIndex
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> FTIntrosPageDataViewController? {
        if (self.pageIdentifiers.count == 0) || (index >= self.pageIdentifiers.count) {
            return nil
        }
        
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier(self.pageIdentifiers[index]) as! FTIntrosPageDataViewController
        dataViewController.user = self.user
        
        return dataViewController
    }
    
    var _user : User? = nil
    
    /// データモデルを返すクラスを返す
    var user : User {
        if _user == nil {
            _user = User.MR_createEntity() as! User?
        }
        return _user!
    }
}
