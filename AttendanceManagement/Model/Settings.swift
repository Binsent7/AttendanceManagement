//
//  Settings.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/06.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import RealmSwift

class Settings: Object {
    dynamic var id              = 1
    dynamic var startHour       = 0
    dynamic var startMinute     = 0
    dynamic var endHour         = 0
    dynamic var endMinute       = 0
    dynamic var restStartHour   = 0
    dynamic var restStartMinute = 0
    dynamic var restEndHour     = 0
    dynamic var restEndMinute   = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}