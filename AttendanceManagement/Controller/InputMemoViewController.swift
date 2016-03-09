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
    @IBOutlet weak var memoDoneButton: UIButton!
    
    func instanciate(memo memo: String = "", completionHandler: InputMemoCompletionHandler?) {
        self.completionHandler = completionHandler
        self.memo = memo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.text = memo
        
        memoDoneButton.hidden = true
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
    
    /// 入力確定ボタン
    @IBAction func onTapMemoDoneButton(sender: AnyObject) {
        // キーボードを閉じる
        memoTextView.resignFirstResponder()
    }
    
    // 閉じる
    private func close() {
        navigationController?.popViewControllerAnimated(true)
    }
}

extension InputMemoViewController: UITextViewDelegate {
    
    // 編集開始された直後にコール
    func textViewDidBeginEditing(textView: UITextView) {
        memoDoneButton.hidden = false
    }
    
    // 編集された際にコール
    func textView(textView: UITextView, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    // 改行ボタン押下時にコール
    func textViewShouldReturn(textView: UITextView) -> Bool {
        return true
    }
    
    // クリアボタン押下時にコール
    func textViewShouldClear(textView: UITextView) -> Bool {
        return true
    }
    
    // 編集完了後にコール
    func textViewDidEndEditing(textView: UITextView) {
        memo = textView.text
        memoDoneButton.hidden = true
    }
}
