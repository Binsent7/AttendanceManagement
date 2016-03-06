//
//  SettingViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/06.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    let sectionTitleList = ["出勤時間","退勤時間","休憩開始時間","休憩終了時間"]
    
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
        
        close()
    }
    
    // キャンセルボタンタップ
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    // 画面を閉じる
    private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    DatePickerが選ばれた際に呼ばれる.
    */
    internal func onDidChangeDate(sender: UIDatePicker){
        print(sender.date)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
