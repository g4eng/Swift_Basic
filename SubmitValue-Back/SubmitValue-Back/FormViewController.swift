//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by G4ENG on 15/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBAction func onSubmit(_ sender: Any) {
        /*
        // presentingViewController 속성을 통해 이전 화면 객체를 읽어온 다음, viewcontroller 타입으로 캐스팅,
        let preVC = self.presentingViewController
        guard let vc = preVC as? ViewController else {
            return
        }
        
        // 값 전달
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
      */
        /*
        // 저장소 방식
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        // 값 저장
        ad?.paramEmail = self.email.text
        ad?.paramUpdate = self.isUpdate.isOn
        ad?.paramInterval = self.interval.value
        */
        
        // userdefault 객체의 인스턴스를 가져옴
        let ud = UserDefaults.standard
        
        // 값 저장
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpdate.isOn, forKey: "Update")
        ud.set(self.interval.value, forKey: "interval")
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
}
