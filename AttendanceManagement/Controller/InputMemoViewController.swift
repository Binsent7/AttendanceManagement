//
//  InputMemoViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/09.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

class InputMemoViewController: UIViewController {
    
    typealias InputMemoCompletionHandler = (String) -> Void
    
    var completionHandler: InputMemoCompletionHandler?
    var memo: String?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    func instanciate(memo memo: String = "", completionHandler: InputMemoCompletionHandler?) {
        self.completionHandler = completionHandler
        self.memo = memo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.text = memo
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        memoTextView.layer.cornerRadius = 6
        memoTextView.layer.borderColor = UIColor.blackColor().CGColor
        memoTextView.layer.borderWidth = 2
    }
    
    /// 決定ボタン
    @IBAction func onTapDoneButton(sender: AnyObject) {
        completionHandler?(memo!)
        close()
    }
    
    /// キャンセルボタン
    @IBAction func onTapCancelButton(sender: AnyObject) {
        close()
    }
    
    // 閉じる
    private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}