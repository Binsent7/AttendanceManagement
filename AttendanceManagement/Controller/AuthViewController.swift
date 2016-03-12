//
//  AuthViewController.swift
//  AttendanceManagement
//
//  Created by hishinuma on 2016/03/12.
//  Copyright © 2016年 Plus. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    
    @IBAction func onTapTestButton(sender: AnyObject) {
        startTouchIDAuth()
    }
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
    
    // 指紋認証を開始
    private func startTouchIDAuth() {
        let context = LAContext()
        var error: NSError?
        
        // Touch ID利用可能確認
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "指紋認証", reply: { success, error in
                if success {
                    print("認証：成功")
                    self.performSegueWithIdentifier("ShowTop", sender: self)
                }
                else {
                    print("認証：失敗")
                }
            })
        }
        else {
            print("Touch IDが利用できない")
            print(error)
        }
    }
}