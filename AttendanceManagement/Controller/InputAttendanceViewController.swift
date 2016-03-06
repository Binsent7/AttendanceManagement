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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attendanceInformation.type          = "出勤"
        attendanceInformation.startTime     = NSDate()
        attendanceInformation.endTime       = NSDate()
        attendanceInformation.lestStartTime = 13
        attendanceInformation.lestEndTime   = 14
        attendanceInformation.memo          = "メモ"
        attendanceInformation.date          = "\(attendanceInformation.startTime.year)\(attendanceInformation.startTime.month)\(attendanceInformation.startTime.day)"
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
        // FIXME: Realmへ保存
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "ShowSelectType") {
//            if let selectTypeViewController = segue.destinationViewController as? SelectTypeViewController {
//                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//                if let cell = tableView.cellForRowAtIndexPath(indexPath) where !cell.textLabel!.text!.isEmpty, let currentText = cell.textLabel!.text {
//                    selectTypeViewController.currentType = currentText
//                }
//            }
//        }
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
            cell.textLabel?.text = "\(attendanceInformation.startTime.year)年\(attendanceInformation.startTime.month)月\(attendanceInformation.startTime.day)日 \(attendanceInformation.startTime.hour)時\(attendanceInformation.startTime.minute)分"
        case 2:
            cell.textLabel?.text = "\(attendanceInformation.endTime.year)年\(attendanceInformation.endTime.month)月\(attendanceInformation.endTime.day)日 \(attendanceInformation.endTime.hour)時\(attendanceInformation.endTime.minute)分"
        case 3:
            cell.textLabel?.text = "\(attendanceInformation.lestStartTime) 〜 \(attendanceInformation.lestEndTime)"
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
//            performSegueWithIdentifier("ShowSelectType", sender: nil)
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