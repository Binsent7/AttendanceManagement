//
//  HourMinutePickerViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/09.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class HourMinutePickerViewController: UIViewController {
    
    typealias HourMinutePickerCompletionHandler = (Int, Int) -> Void
    
    var completionHandler: HourMinutePickerCompletionHandler?
    
    var hour: Int!
    var minute: Int!
    
    private var pickerTitleList = ["時","分"]
    private var hourList = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    private var minuteList = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    func instanciate(hour hour: Int, minute: Int, completionHandler: HourMinutePickerCompletionHandler?) {
        self.completionHandler = completionHandler
        self.hour = hour
        self.minute = minute
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.selectRow(hour, inComponent: 0, animated: true)
        pickerView.selectRow(minute, inComponent: 1, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 決定ボタンタップ
    @IBAction func onTapDoneButon(sender: AnyObject) {
        let hourIndex = pickerView.selectedRowInComponent(0)
        let minuteIndex = pickerView.selectedRowInComponent(1)
        hour = hourList[hourIndex]
        minute = minuteList[minuteIndex]
        completionHandler?(hour, minute)
        close()
    }
    
    // キャンセルボタンタップ
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    // 画面を閉じる
    private func close() {
        navigationController?.popViewControllerAnimated(true)
    }
}

extension HourMinutePickerViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? hourList.count : minuteList.count
    }
}

extension HourMinutePickerViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(format: "%02d",hourList[row])
        case 1:
            return String(format: "%02d",minuteList[row])
        default:
            return nil
        }
    }
}