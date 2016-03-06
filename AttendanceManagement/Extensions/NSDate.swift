//
//  NSDate.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/06.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation

extension NSDate {
    @nonobjc static let zero = NSDate(timeIntervalSince1970: 0.0)
    
    static func defaultDateComponents(year year: Int, month: Int, day: Int) -> NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        dateComponents.timeZone = NSTimeZone(name: "ja_JP")
        dateComponents.year     = year
        dateComponents.month    = month
        dateComponents.day      = day
        dateComponents.hour     = 0
        dateComponents.minute   = 0
        return dateComponents
    }
}