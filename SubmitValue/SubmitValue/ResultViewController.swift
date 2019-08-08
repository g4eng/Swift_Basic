//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by G4ENG on 11/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // 화면에 값을 표시하늗네 사용될 레이블
    @IBOutlet var resultEmail: UILabel! // 이메일
    @IBOutlet var resultRenew: UILabel! // 자동갱신 여부
    @IBOutlet var resultInterval: UILabel! // 갱신주기
    
    // 1. email 값을 받을 변수
    var paramEmail: String = ""
    // 2. renew 값을 받을 변수
    var paramRenew: Bool = false
    // 3. interval 값을 받을 변수
    var paramInterval: Double = 0
    
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail
        self.resultRenew.text = (self.paramRenew == true ? "자동갱신" : "자동갱신안함")
        self.resultInterval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
