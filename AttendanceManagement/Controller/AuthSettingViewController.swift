//
//  AuthSettingViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/09.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class AuthSettingViewController: UIViewController {
    let sectionTitleList = ["パスワード設定","指紋認証"]
    
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
    
    // 保存ボタンタップ
    @IBAction func onTapSaveButon(sender: AnyObject) {
        // FIXME: 保存する処理
        
        // FIXME: 完了ダイアログ
        
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