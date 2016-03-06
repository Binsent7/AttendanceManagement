//
//  SelectTypeViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/04.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit

class SelectTypeViewController: UIViewController {
    
    private let typeList: [String] = ["出勤","徹夜","徹夜明","出張","欠勤","有休A","有休B","半休A","半休B","振休","特休","遅刻A","遅刻B","早出","休日"]
    
    var currentType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "種別選択"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SelectTypeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = typeList[indexPath.row]
        
        if cell.textLabel?.text == currentType {
            cell.accessoryType = .Checkmark
        }
        return cell
    }
}

extension SelectTypeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルの選択状態を解除
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        navigationController?.popViewControllerAnimated(true)
    }
}
