//
//  MainViewController.swift
//  YBTest
//
//  Created by ParaBellum on 11/27/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var pagingControll: PagingControl?
    weak var pageVC:PageViewController?
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        
      

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pagingControll?.delegate = pageVC!
        pageVC?.pagingDelegate = pagingControll
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageVC"{
            let pageVC = segue.destination as! PageViewController
            self.pageVC = pageVC
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return self.view.frame.size.height - 64 - 50 - 40
        default:
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1: return 40
        default:
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            pagingControll = PagingControl(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40))
            return pagingControll
        default:
            return nil
        }
    }
    

}