//
//  InputAttendanceViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/02.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class InputAttendanceViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    /// 決定ボタン
    @IBAction func onTapDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// キャンセルボタン
    @IBAction func onTapCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


extension InputAttendanceViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        return cell
    }
}

extension InputAttendanceViewController: UITableViewDelegate {
    
}