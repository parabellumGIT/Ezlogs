//
//  PageViewController.swift
//  YBTest
//
//  Created by ParaBellum on 11/27/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
protocol PageViewControllerDelegate:AnyObject {
    func didSwipeToVC(at index:Int)
}
class PageViewController: UIPageViewController, PagingControlDelegate {
    lazy var VCArr:[UIViewController] = {
        return [self.VCInstance(name:"FirstTableViewController"),
                self.VCInstance(name:"SecondTableViewController"),
                self.VCInstance(name:"ThirdTableViewController")]
    }()
    
    func didSelectTab(index: Int) {
        currentIndex = index
    }
    weak var pagingDelegate:PageViewControllerDelegate?
    
    var currentIndex:Int {
        get {
            return VCArr.index(of: self.viewControllers!.first!)!
        }
        
        set {
            guard newValue >= 0,
                newValue < VCArr.count else {
                    return
            }
            
            let vc = VCArr[newValue]
            let direction:UIPageViewControllerNavigationDirection = newValue > currentIndex ? .forward : .reverse
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        }
    }
    
    
    private func VCInstance(name:String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:name)
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Install this class as the data source
        dataSource = self
        delegate = self
        
        // Install the first-presented view controller
        if let firstVC = VCArr.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
extension PageViewController:UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        

        
        let previousIndex = currentIndex - 1
        guard  previousIndex >= 0  else {
            return nil
        }
        guard  VCArr.count > previousIndex else {
            return nil
        }
        return VCArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let nextIndex = currentIndex + 1
        
        guard  nextIndex < VCArr.count  else {
            return nil
        }
        guard VCArr.count > nextIndex else{
            return nil
        }
        return VCArr[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstVCIndex = VCArr.index(of: firstVC) else{
            return 0
        }
        return firstVCIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pagingDelegate?.didSwipeToVC(at: currentIndex)
    }
    
}
