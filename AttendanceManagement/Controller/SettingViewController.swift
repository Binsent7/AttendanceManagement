//
//  SettingViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/06.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    let sectionTitleList = ["基本設定","認証"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 閉じるボタンタップ
    @IBAction func onTapCloseButton(sender: AnyObject) {
        close()
    }
    
    // 画面を閉じる
    private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = sectionTitleList[indexPath.section]
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var segueIdentifier = ""
        switch indexPath.section {
        case 0:
            // 種別選択画面
            segueIdentifier = "ShowBasicSetting"
        case 1:
            // 日時選択画面
            segueIdentifier = "ShowAuthSetting"
        default:
            break
        }
        
        if !segueIdentifier.isEmpty {
            performSegueWithIdentifier(segueIdentifier, sender: self)
        }
    }
}
