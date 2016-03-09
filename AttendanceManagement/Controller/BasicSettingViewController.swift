//
//  BasicSettingViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/09.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class BasicSettingViewController: UIViewController {
    let sectionTitleList = ["出勤時間","退勤時間","休憩開始時間","休憩終了時間"]
    
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
    
    // 保存ボタンタップ
    @IBAction func onTapSaveButon(sender: AnyObject) {
        // FIXME: 保存する処理
        close()
    }
    
    // キャンセルボタンタップ
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    // 画面を閉じる
    private func close() {
        navigationController?.popViewControllerAnimated(true)
    }
}

extension BasicSettingViewController: UITableViewDataSource {
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

extension BasicSettingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var segueIdentifier = ""
        switch indexPath.section {
        case 0:
            // 出勤時間
            segueIdentifier = "ShowBasicSettingStartTime"
        case 1:
            // 退勤時間
            segueIdentifier = "ShowBasicSettingEndTime"
        case 2:
            // 休憩開始時間
            segueIdentifier = "ShowBasicSettingRestStartTime"
        case 3:
            // 休憩終了時間
            segueIdentifier = "ShowBasicSettingRestEndTime"
        default:
            break
        }
        
        if !segueIdentifier.isEmpty {
            performSegueWithIdentifier(segueIdentifier, sender: self)
        }
    }
}