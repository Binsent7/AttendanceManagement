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
        title = "\(date.year)年 \(date.month)月"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "ShowInputAttendance",
            let navigationController = segue.destinationViewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? InputAttendanceViewController {
                let date = calendarView.presentedDate
                let currentDate = NSDate(components: NSDate.defaultDateComponents(year: date.year, month: date.month, day: date.day))!
                viewController.currentDate = currentDate + 1.days
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
