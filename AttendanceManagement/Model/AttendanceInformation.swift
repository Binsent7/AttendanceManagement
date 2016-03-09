//
//  AttendanceInformation.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/06.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftDate

class AttendanceInformation: Object {
    dynamic var date            = ""
    dynamic var type            = ""
    dynamic var startTime       = NSDate.zero
    dynamic var endTime         = NSDate.zero
    dynamic var restStartTime   = NSDate.zero
    dynamic var restEndTime     = NSDate.zero
    dynamic var memo            = ""
    dynamic var workTime        = 0.0
    
    override static func primaryKey() -> String? {
        return "date"
    }
}

extension AttendanceInformation {
    // プライマリーキーに変換
    static func convertPrimaryKey(year year: Int = 0, month: Int = 0, day: Int = 0) -> String {
        guard year != 0 && month != 0 && day != 0 else {
            return ""
        }
        return String(format: "%02d/%02d/%02d",year,month,day)
    }
    
    // 勤務時間を計算
    func updateWorkTime() {
        workTime = totalWorkTime - restTime
    }
    
    // 開始時間
    var startTimeDisplay: String {
        return String(format: "%02d/%02d/%02d %02d:%02d",startTime.year,startTime.month,startTime.day,startTime.hour,startTime.minute)
    }
    // 終了時間
    var endTimeDisplay: String {
        return String(format: "%02d/%02d/%02d %02d:%02d",endTime.year,endTime.month,endTime.day,endTime.hour,endTime.minute)
    }
    // 休憩開始時間
    var restStartTimeDisplay: String {
        return String(format: "%02d:%02d",restStartTime.hour,restStartTime.minute)
    }
    // 休憩終了時間
    var restEndTimeDisplay: String {
        return String(format: "%02d:%02d",restEndTime.hour,restEndTime.minute)
    }
    // 作業時間
    var totalWorkTime: NSTimeInterval {
        return abs(startTime.timeIntervalSinceDate(endTime))
    }
    // 休憩時間
    var restTime: NSTimeInterval {
        return abs(restStartTime.timeIntervalSinceDate(restEndTime))
    }
}