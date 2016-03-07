//
//  SelectDateTimeViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/07.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

class SelectDateTimeViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    typealias SelectDateTimeCompletionHandler = (NSDate) -> Void
    
    var completionHandler: SelectDateTimeCompletionHandler?
    var currentDate: NSDate?
    
    func instanciate(date date: NSDate = NSDate(), completionHandler: SelectDateTimeCompletionHandler?) {
        self.completionHandler = completionHandler
        currentDate = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "日時選択"
        datePicker.date = currentDate!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    /// 決定ボタン
    @IBAction func onTapDoneButton(sender: AnyObject) {
        close()
        completionHandler?(datePicker.date)
    }
    
    /// キャンセルボタン
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    /// 画面を閉じる
    private func close() {
        navigationController?.popViewControllerAnimated(true)
    }
}