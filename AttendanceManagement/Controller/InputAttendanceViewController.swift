//
//  InputAttendanceViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/02.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate
import RealmSwift

class InputAttendanceViewController: UIViewController {
    
    typealias InputAttendanceCompletionHandler = (Void -> Void)
    
    var completionHandler: InputAttendanceCompletionHandler?
    var attendanceInformation = AttendanceInformation()
    var currentDate = NSDate.zero
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateComponents = NSDate.defaultDateComponents(year: currentDate.year, month: currentDate.month, day: currentDate.day)
        let startTimeComponents         = dateComponents + 10.hours
        let endTimeComponents           = dateComponents + 19.hours
        let restStartTimeComponents     = dateComponents + 13.hours
        let restEndTimeComponents       = dateComponents + 14.hours
        attendanceInformation.type          = "出勤"
        attendanceInformation.startTime     = NSDate(components: startTimeComponents)!
        attendanceInformation.endTime       = NSDate(components: endTimeComponents)!
        attendanceInformation.restStartTime = NSDate(components: restStartTimeComponents)!
        attendanceInformation.restEndTime   = NSDate(components: restEndTimeComponents)!
        attendanceInformation.memo          = "メモ"
        attendanceInformation.date          = AttendanceInformation.convertPrimaryKey(year: attendanceInformation.startTime.year, month: attendanceInformation.startTime.month, day: attendanceInformation.startTime.day)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    /// 決定ボタン
    @IBAction func onTapDoneButton(sender: AnyObject) {
        saveAttendance()
        close()
    }
    
    /// キャンセルボタン
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
        
    // Realmに保存
    private func saveAttendance() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(attendanceInformation, update: true)
        }
    }
    
    // 閉じる
    private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension InputAttendanceViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
//        if indexPath.section == 0 {
//            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        }
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = attendanceInformation.type
        case 1:
            cell.textLabel?.text = "\(attendanceInformation.startTimeDisplay)"
        case 2:
            cell.textLabel?.text = "\(attendanceInformation.endTimeDisplay)"
        case 3:
            cell.textLabel?.text = "\(attendanceInformation.restStartTimeDisplay) 〜 \(attendanceInformation.restEndTimeDisplay)"
        case 4:
            cell.textLabel?.text = attendanceInformation.memo
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "種別"
        case 1:
            return "開始時間"
        case 2:
            return "終了時間"
        case 3:
            return "休憩時間"
        case 4:
            return "その他"
        default:
            return nil
        }
    }
}

extension InputAttendanceViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルの選択状態を解除
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            print("種別")
        case 1:
            print("開始時間")
        case 2:
            print("終了時間")
        case 3:
            print("休憩時間")
        case 4:
            print("その他")
        default:
            break
        }
    }
}