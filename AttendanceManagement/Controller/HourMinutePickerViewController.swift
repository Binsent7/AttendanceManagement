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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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