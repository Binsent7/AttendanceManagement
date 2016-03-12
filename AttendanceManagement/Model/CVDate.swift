//
//  CVDate.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/02/28.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import SwiftDate
import CVCalendar

extension CVDate {
    
    var holidayName: String {
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let formatter = NSDateFormatter()
        formatter.locale = locale
        var holidayName = ""
        
        let date = self.date + 1.days
        
        switch date.month {
        case 1:
            if date.day == 1 {
                holidayName = "元旦"
            }
            if date.day == 2 && date.weekday == 1 {
                holidayName = "元旦(振替休日)"
            }
            if date.day >= 8 && date.day <= 14 && date.weekday == 1 {
                holidayName = "成人の日"
            }
        case 2:
            if date.day == 11 {
                holidayName = "建国記念の日"
            }
            if date.day == 12 && date.weekday == 1 {
                holidayName = "建国記念の日(振替休日)"
            }
        case 3:
            let a = 20.8431 + 0.242194 * Float(date.year - 1980)
            let b = (date.year - 1980) / 4
            let year = Int(a) - b
            if date.year == year {
                holidayName = "春分の日"
            }
            if date.year == year + 1 && date.weekday == 1 {
                holidayName = "春分の日(振替休日)"
            }
        case 4:
            if date.day == 29 {
                holidayName = "昭和の日"
            }
            if date.day == 30 && date.weekday == 1 {
                holidayName = "昭和の日(振替休日)"
            }
        case 5:
            if date.day == 3 {
                holidayName = "憲法記念日"
            }
            if date.day == 4 {
                holidayName = "みどりの日"
            }
            if date.day == 5 {
                holidayName = "こどもの日"
            }
            if date.day == 6 && (date.weekday == 1 || date.weekday == 2 || date.weekday == 3) {
                holidayName = "こどもの日(振替休日)"
            }
        case 7:
            if date.day >= 15 && date.day <= 21 && date.weekday == 1 {
                holidayName = "海の日"
            }
        case 8:
            if date.year > 2015 && date.day == 11 {
                holidayName = "山の日"
            }
            if date.year > 2015 && date.day == 12 && date.weekday == 1 {
                holidayName = "山の日(振替休日)"
            }
        case 9:
            if date.day >= 15 && date.day <= 21 && date.weekday == 1 {
                holidayName = "敬老の日"
            }
            let a = 23.2488 + 0.242194 * Float(date.year - 1980)
            let b = (date.year - 1980) / 4
            let year = Int(a) - b
            if year == 23 && date.day == 22{
                holidayName = "秋分の日"
            }
            if date.day == year {
                holidayName = "秋分の日"
            }
            if date.day == year + 1 && date.weekday == 1 {
                holidayName = "秋分の日(振替休日)"
            }
        case 10:
            if date.day >= 8 && date.day <= 14 && date.weekday == 1 {
                holidayName = "体育の日"
            }
        case 11:
            if date.day == 3 {
                holidayName = "文化の日"
            }
            if date.day == 4 && date.weekday == 1 {
                holidayName = "文化の日(振替休日)"
            }
            if date.day == 23 {
                holidayName = "勤労感謝の日"
            }
            if date.day == 24 && date.weekday == 1 {
                holidayName = "勤労感謝の日(振替休日)"
            }
        case 12:
            if date.day == 23 {
                holidayName = "天皇誕生日"
            }
            if date.day == 24 && date.weekday == 1 {
                holidayName = "天皇誕生日(振替休日)"
            }
        default:
            holidayName = ""
        }
        return holidayName
    }
}