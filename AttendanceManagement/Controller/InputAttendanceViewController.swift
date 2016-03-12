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
    
    // FIXME: segue.identifierの定数定義
    
    typealias InputAttendanceCompletionHandler = Void -> Void
    
    var completionHandler: InputAttendanceCompletionHandler?
    var attendanceInformation = AttendanceInformation()
    var currentDate = NSDate.zero
    
    let sectionTitleList = ["種別","開始時間","終了時間","休憩開始時間","休憩終了時間","その他"]
    
    @IBOutlet weak var tableView: UITableView!
    
    func instanciate(date date: NSDate = NSDate(), completionHandler: InputAttendanceCompletionHandler?) {
        self.completionHandler = completionHandler
        currentDate = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let id = AttendanceInformation.convertPrimaryKey(year: currentDate.year, month: currentDate.month, day: currentDate.day)
        if let savedData = realm.objectForPrimaryKey(AttendanceInformation.self, key: id) {
            attendanceInformation = AttendanceInformation(value: savedData)
        }
        else {
            defaultAttendanceInformation()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSelectType", let viewController = segue.destinationViewController as? SelectTypeViewController {
            // 種別選択画面
            viewController.instanciate() { [weak self] selectedType in
                self?.attendanceInformation.type = selectedType
                self?.tableView.reloadData()
            }
        }
        else if segue.identifier == "ShowSelectStartDateTime", let viewController = segue.destinationViewController as? SelectDateTimeViewController {
            // 開始時間選択画面
            viewController.instanciate(date: attendanceInformation.startTime) { [weak self] selectedDate in
                self?.attendanceInformation.startTime = selectedDate
                self?.tableView.reloadData()
            }
        }
        else if segue.identifier == "ShowSelectEndDateTime", let viewController = segue.destinationViewController as? SelectDateTimeViewController {
            // 終了時間選択画面
            viewController.instanciate(date: attendanceInformation.endTime) { [weak self] selectedDate in
                self?.attendanceInformation.endTime = selectedDate
                self?.tableView.reloadData()
            }
        }
        else if segue.identifier == "ShowSelectRestStartDateTime", let viewController = segue.destinationViewController as? SelectDateTimeViewController {
            // 休憩開始時間選択画面
            viewController.instanciate(date: attendanceInformation.restStartTime) { [weak self] selectedDate in
                self?.attendanceInformation.restStartTime = selectedDate
                self?.tableView.reloadData()
            }
        }
        else if segue.identifier == "ShowSelectRestEndDateTime", let viewController = segue.destinationViewController as? SelectDateTimeViewController {
            // 休憩終了時間選択画面
            viewController.instanciate(date: attendanceInformation.restEndTime) { [weak self] selectedDate in
                self?.attendanceInformation.restEndTime = selectedDate
                self?.tableView.reloadData()
            }
        }
        else if segue.identifier == "ShowMemo", let viewController = segue.destinationViewController as? InputMemoViewController {
            // 備考入力画面
            viewController.instanciate(memo: attendanceInformation.memo) { [weak self] memo in
                self?.attendanceInformation.memo = memo
                self?.tableView.reloadData()
            }
        }
    }
    
    /// 決定ボタン
    @IBAction func onTapDoneButton(sender: AnyObject) {
        attendanceInformation.updateWorkTime()
        saveAttendance()
        close()
        completionHandler?()
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
    
    // 勤怠情報を初期化
    private func defaultAttendanceInformation() {
        var startHour: Int = 9
        var startMinute: Int = 0
        var endHour: Int = 18
        var endMinute: Int = 0
        var restStartHour: Int = 12
        var restStartMinute: Int = 0
        var restEndHour: Int = 13
        var restEndMinute: Int = 0
        let realm = try! Realm()
        if let value = realm.objectForPrimaryKey(BasicAttendance.self, key: "1") {
            let basicAttendance = BasicAttendance(value: value)
            startHour = basicAttendance.startHour
            startMinute = basicAttendance.startMinute
            endHour = basicAttendance.endHour
            endMinute = basicAttendance.endMinute
            restStartHour = basicAttendance.restStartHour
            restStartMinute = basicAttendance.restStartMinute
            restEndHour = basicAttendance.restEndHour
            restEndMinute = basicAttendance.restEndMinute
        }
        
        let dateComponents = NSDate.defaultDateComponents(year: currentDate.year, month: currentDate.month, day: currentDate.day)
        let startTimeComponents         = dateComponents + startHour.hours + startMinute.minutes
        let endTimeComponents           = dateComponents + endHour.hours + endMinute.minutes
        let restStartTimeComponents     = dateComponents + restStartHour.hours + restStartMinute.minutes
        let restEndTimeComponents       = dateComponents + restEndHour.hours + restEndMinute.minutes
        attendanceInformation.type          = "出勤"
        attendanceInformation.startTime     = NSDate(components: startTimeComponents)!
        attendanceInformation.endTime       = NSDate(components: endTimeComponents)!
        attendanceInformation.restStartTime = NSDate(components: restStartTimeComponents)!
        attendanceInformation.restEndTime   = NSDate(components: restEndTimeComponents)!
        attendanceInformation.memo          = ""
        attendanceInformation.date          = AttendanceInformation.convertPrimaryKey(year: attendanceInformation.startTime.year, month: attendanceInformation.startTime.month, day: attendanceInformation.startTime.day)

    }
}

extension InputAttendanceViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        if indexPath.section == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = attendanceInformation.type
        case 1:
            cell.textLabel?.text = "\(attendanceInformation.startTimeDisplay)"
        case 2:
            cell.textLabel?.text = "\(attendanceInformation.endTimeDisplay)"
        case 3:
            cell.textLabel?.text = "\(attendanceInformation.restStartTimeDisplay)"
        case 4:
            cell.textLabel?.text = "\(attendanceInformation.restEndTimeDisplay)"
        case 5:
            cell.textLabel?.text = attendanceInformation.memo
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
}

extension InputAttendanceViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルの選択状態を解除
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var segueIdentifier = ""
        switch indexPath.section {
        case 0:
            // 種別選択画面
            segueIdentifier = "ShowSelectType"
        case 1:
            // 日時選択画面
            segueIdentifier = "ShowSelectStartDateTime"
        case 2:
            // 日時選択画面
            segueIdentifier = "ShowSelectEndDateTime"
        case 3:
            // 日時選択画面
            segueIdentifier = "ShowSelectRestStartDateTime"
        case 4:
            // 日時選択画面
            segueIdentifier = "ShowSelectRestEndDateTime"
        case 5:
            // 備考選択画面
            segueIdentifier = "ShowMemo"
        default:
            break
        }
        
        if !segueIdentifier.isEmpty {
            performSegueWithIdentifier(segueIdentifier, sender: self)
        }
    }
}