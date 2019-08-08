//
//  ViewController.swift
//  SubmitValue
//
//  Created by G4ENG on 11/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// 개별 타입을 선택해야 할 때: 액션 메소드를 호출한 컨트롤의 속성값이 필요하거나, 이를 제어해야 할 때
// Any 타입을 선택해야 할 때:
// 1. 서로 다른 타입의 컨트롤이 동일한 액션 메소드를 호출하게끔 처리하고 싶을때
// 2. 액션 메소드를 호출한 컨트롤의 정보가 필요 없을 때
// 3. 개별 타입을 반드시 사용해야 하는 경우를 제외한 나머지 모든 경우

class ViewController: UIViewController {

    @IBOutlet var email: UITextField!   // 이메일 주소 입력받는 텍스트필드
    @IBOutlet var isRenew: UISwitch!    // 자동갱신 ㅏ
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.isRenewText.text = "Renew"
        }
        else {
            self.isRenewText.text = "No renew"
        }
        
        // 매개변수가 Any로 선언된 경우
        /*
          // 옵셔널 캐스팅
         guard let obj = sender as? UISwitch else {
            return
         }
         
         is obj.isOn == true {
            self.i ~~~
         }
         else {
            self.~~~
         }
        */
    }
    
    @IBOutlet var interval: UIStepper!
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalTime.text = "\(value)분 마다"
        
        // 매개변수 타입이 Any 일때
        /*
         // 강제 캐스팅
         let obj = sender as! UIStepper
         
         let value = Int(obj.value)
         */
    }
    
    @IBOutlet var isRenewText: UILabel!
    @IBOutlet var intervalTime: UILabel!
    
    @IBAction func onSubmit(_ sender: Any) {
        // VC2의 인스턴스 생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else { return }
        // 값을 전달하는 과정을 여기에 작성
        rvc.paramEmail = self.email.text!
        rvc.paramRenew = self.isRenew.isOn
        rvc.paramInterval = self.interval.value
        
        // 화면 이동
        // self.present(rvc, animated: true)
        
        // 내비를 이용할 땐 navi~.push~
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    // 세그웨이 실행을 위한 준비 메소드 부분에 값을 전달해 준다. 앞에서 배운 세그웨이 전처리 메소드인 prepare(for:sender:) 메소드가 드디어 제 역할을 하는 순간이다. 이 메소드는 앞에서 설명한 대로, 세그웨이가 실행되기 직전에 호출되는 메소드다. 이 메소드는 우리가 직접 호출하는 것이 아니라 필요한 내용을 작성해 준 다음 가만히 놔두면 iOS에서 알아서 적절한 시점에 호출한다.
    // instatnstiateViewController(withIdentifier:)를 사용해서 직접 생성했다. 하지만 세그웨이를 다룰 때에는 이동할 대상 뷰컨의 인스턴스를 우리가 직접 생성하면 안된다.
    // 세그웨이에 자동으로 생성되기 때문에, 우리가 앞서의 메소드를 이용하여 생성한 인스턴스와 일치하지 않는다.
    // 그러니 우리는 직접 뷰컨의 인스턴스를 생성하는 대신 세그웨이 객체를 통해 생성된 뷰컨 인스턴스 참조를 읽어와야 한다. 이 정보는 prepare(for:sender:)의 첫 번재 인자값인 segue 매개변수를 통해 얻을 수 있다.
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self) //작동할 세그웨이 찾기
    }
    
    // 1. 메소드의 매개변수 segue의 속성 destination를 이용하여 목적지 뷰컨의 인스턴스를 참조하여 가져온다.
    // 2. 인스턴스의 타입을 UIViewController에서 타입으로 캐스팅. 실패하면 메소드 실행 종료
    // 3. 캐스팅된 인스턴스 상수 rvc를 이용하여 값 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 목적지 뷰컨 인스턴스 읽어오기, 세그웨이가 알아서 불러와줌
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else { return }
        //값전달
        rvc.paramEmail = self.email.text!
        rvc.paramRenew = self.isRenew.isOn
        rvc.paramInterval = self.interval.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }ㅈ

}

