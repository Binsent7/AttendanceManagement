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
    dynamic var restStartTime   = NSDate()
    dynamic var restEndTime     = NSDate()
    dynamic var memo            = ""
    
    override static func primaryKey() -> String? {
        return "date"
    }
}