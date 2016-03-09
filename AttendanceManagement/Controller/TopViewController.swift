//
//  TopViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/02/21.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar
import RealmSwift
import SwiftDate

class TopViewController: UIViewController {
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var MemoLabel: UILabel!
    
    @IBOutlet weak var noInputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateTitle(date: NSDate())
        updateCuttentAttendance(date: calendarView.presentedDate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    /// 今日ボタンタップ時にコール
    @IBAction func onTapTodayButton(sender: AnyObject) {
        calendarView.presentedDate = CVDate(date: NSDate())
        
        // FIXME: 選択状態も更新する
    }
    
    // 指定の勤怠情報を更新
    private func updateCuttentAttendance(date date: CVDate) {
        let realm = try! Realm()
        
        let id = AttendanceInformation.convertPrimaryKey(year: date.year, month: date.month, day: date.day)
        if let attendance = realm.objectForPrimaryKey(AttendanceInformation.self, key: id) {
            noInputView.hidden  = true
            typeLabel.text      = attendance.type
            startTimeLabel.text = "\(attendance.startTimeDisplay)"
            endTimeLabel.text   = "\(attendance.endTimeDisplay)"
            restTimeLabel.text  = "\(attendance.restStartTimeDisplay) 〜 \(attendance.restEndTimeDisplay)"
            MemoLabel.text      = "\(attendance.memo)"
        }
        else {
            noInputView.hidden = false
            typeLabel.text      = ""
            startTimeLabel.text = ""
            endTimeLabel.text   = ""
            restTimeLabel.text  = ""
            MemoLabel.text      = ""
        }
    }
    
    // タイトルを更新
    private func updateTitle(date date: NSDate) {
        let date = CVDate(date: date)
        // FIXME: 計算について仮
        title = "\(date.year)年 \(date.month)月 勤務時間：\(countMonthTotalTime() / 60 / 60)時間"
    }
    
    // 指定月の累計勤怠時間を計算
    private func countMonthTotalTime() -> Double {
        let realm = try! Realm()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let timeZone = NSTimeZone(name: "ja_JP")
        let locale = NSLocale.currentLocale()
        
        let region = Region(cal: calendar, tz: timeZone, loc: locale)
        let firstDate = calendarView.presentedDate.date.startOf(.Month, inRegion: region)
        let endDate = calendarView.presentedDate.date.endOf(.Month, inRegion: region)
        let monthPredicate = NSPredicate(format: "%@ <= startTime && startTime <= %@", firstDate,endDate)
        let attendanceListForMonth = realm.objects(AttendanceInformation).filter(monthPredicate)
        
        var totalMonthWorkTime = 0.0
        attendanceListForMonth.forEach {
            print("=============")
            print($0.workTime)
            print($0.totalWorkTime)
            print($0.restTime)
            totalMonthWorkTime += $0.workTime
        }
        
        return totalMonthWorkTime
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowInputAttendance",
            let navigationController = segue.destinationViewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? InputAttendanceViewController {
                let date = calendarView.presentedDate
                let currentDate = NSDate(components: NSDate.defaultDateComponents(year: date.year, month: date.month, day: date.day))!
                viewController.instanciate(date: currentDate + 1.days, completionHandler: nil)
        }
    }
}

// MARK: - CVCalendarMenuViewDelegate

extension TopViewController: CVCalendarMenuViewDelegate {
    /// 最初に表示する曜日
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    /// 曜日のフォント
    func dayOfWeekFont() -> UIFont {
        return UIFont.boldSystemFontOfSize(15)
    }
    /// 表示を表示する種別
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    /// 表示する曜日の文字色
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.blackColor()
    }
}

// MARK: - CVCalendarViewDelegate

extension TopViewController: CVCalendarViewDelegate {
    /// 表示モード
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    /// リサイズ時のアニメーション
    func shouldAnimateResizing() -> Bool{
        return false
    }
    /// 週切り替え時に自動的に指定するか
    func shouldAutoSelectDayOnWeekChange() -> Bool {
        return false
    }
    /// 月切り替え時に自動的に指定するか
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    /// 表示月以外の日付表示判定
    func shouldShowWeekdaysOut() -> Bool {
        return false
    }
    // 日付が更新された際にコール
    func presentedDateUpdated(date: Date) {
        updateCuttentAttendance(date: date)
    }
    
    // マーカー設定関連
    
    /// 点マーカーを表示するか
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        // FIXME: 勤怠が入力されているか判定
        return false
    }
    /// 点マーカーの色設定
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        return [UIColor.lightGrayColor()]
    }
    // 点マーカーのサイズ
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    // 日付の背景関連
    
    // 背景のView設定
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        // FIXME: 土：青色 日・祝：赤色
        
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: .Circle)
        circleView.fillColor = UIColor.orangeColor()
        return circleView
    }
    
    // 背景Viewを表示するかの判定
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        // FIXME: 休日判定の実装
//        if let date = dayView.date {
//            return !date.holidayName.isEmpty
//        }
        return false
   }
    
    func didShowNextMonthView(date: NSDate) {
        updateTitle(date: date)
    }
    func didShowPreviousMonthView(date: NSDate) {
        updateTitle(date: date)
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension TopViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return true
    }
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
}
