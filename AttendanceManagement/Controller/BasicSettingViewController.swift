//
//  BasicSettingViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/09.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class BasicSettingViewController: UIViewController {
    let sectionTitleList = ["出勤時間","退勤時間","休憩開始時間","休憩終了時間"]
    
    // FIXME: segue.identifierを定数定義
    
    @IBOutlet weak var tableView: UITableView!
    
    var basicAttendance: BasicAttendance!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        if let basicAttendance = realm.objectForPrimaryKey(BasicAttendance.self, key: "1") {
            self.basicAttendance = BasicAttendance(value: basicAttendance)
        }
        else {
            basicAttendance = BasicAttendance()
            basicAttendance.startHour       = 9
            basicAttendance.startMinute     = 0
            basicAttendance.endHour         = 18
            basicAttendance.endMinute       = 0
            basicAttendance.restStartHour   = 12
            basicAttendance.restStartMinute = 0
            basicAttendance.restEndHour     = 13
            basicAttendance.restEndMinute   = 0
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? HourMinutePickerViewController {
            if segue.identifier == "ShowBasicSettingStartTime" {
                // 出勤時間
                viewController.instanciate(hour: basicAttendance.startHour, minute: basicAttendance.startMinute) { hour, minute in
                    self.basicAttendance.startHour = hour
                    self.basicAttendance.startMinute = minute
                    self.tableView.reloadData()
                }
            }
            else if segue.identifier == "ShowBasicSettingEndTime" {
                // 退勤時間
                viewController.instanciate(hour: basicAttendance.endHour, minute: basicAttendance.endMinute) { hour, minute in
                    self.basicAttendance.endHour = hour
                    self.basicAttendance.endMinute = minute
                    self.tableView.reloadData()
                }
            }
            else if segue.identifier == "ShowBasicSettingRestStartTime" {
                // 休憩開始時間
                viewController.instanciate(hour: basicAttendance.restStartHour, minute: basicAttendance.restStartMinute) { hour, minute in
                    self.basicAttendance.restStartHour = hour
                    self.basicAttendance.restStartMinute = minute
                    self.tableView.reloadData()
                }
            }
            else if segue.identifier == "ShowBasicSettingRestEndTime" {
                // 休憩終了時間
                viewController.instanciate(hour: basicAttendance.restEndHour, minute: basicAttendance.restEndMinute) { hour, minute in
                    self.basicAttendance.restEndHour = hour
                    self.basicAttendance.restEndMinute = minute
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // 保存ボタンタップ
    @IBAction func onTapSaveButon(sender: AnyObject) {
        saveBasicAttendance()
        close()
    }
    
    // キャンセルボタンタップ
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    private func saveBasicAttendance() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(basicAttendance, update: true)
        }
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
        var hour = 0
        var minute = 0
        switch indexPath.section {
        case 0:
            hour = basicAttendance.startHour
            minute = basicAttendance.startMinute
        case 1:
            hour = basicAttendance.endHour
            minute = basicAttendance.endMinute
        case 2:
            hour = basicAttendance.restStartHour
            minute = basicAttendance.restStartMinute
        case 3:
            hour = basicAttendance.restEndHour
            minute = basicAttendance.restEndMinute
        default:
            break
        }
        cell.textLabel?.text = String(format: "%02d : %02d",hour, minute)
        return cell
    }
}

extension BasicSettingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
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