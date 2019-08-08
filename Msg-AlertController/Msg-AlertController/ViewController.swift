//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by G4ENG on 16/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

/*
// 메시지창 컨트롤러 인스턴스 생성
let alert = UIAlertController(title: "알림", message: "AlertController 샘플", preferredStyle: UIAlertController.Style.alert)
 // preferredStyle: UIAlert~ -> preferredStyle: .alert 열거형 축약 표현으로 사용 가능
 
// 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
 //           UIAlertAciton(title: "취소", style: .cancel, handler: nil)
 //          UIAlertAction(title: "취소", style: .cancel, handelr: { (_) in})
 //           UIAlertAction(~~~, style: .cancel) { (_) in
            // 버튼을 클릭했을 때 실행할 구문을 작성
 //}
// 메시지 창 컨트롤러에 버튼 액션 추가
 alert.addAction(cancel)
 
 // 메시지 창 컨트롤러를 표시한다
 self.present(alert,animated: false)
*/
// 메세지 창 컨트롤러에
class ViewController: UIViewController {
    @IBOutlet var result: UILabel!
    
    override func viewDidLoad() {
        // 메시지 창을 처리하기 부적절한 위치(아직 뷰가 화면에 구현되기 전)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 메시지 창을 처리하기 적절한 위치
    }
    
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "항목을 선택하세요", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (_) in
            self.result.text = "취소 버튼"
        }
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            self.result.text = "확인 버튼"
        }
        let exec = UIAlertAction(title: "실행", style: .destructive) { (_) in
            self.result.text = "실행 버튼"
        }
        let stop = UIAlertAction(title: "중지", style: .default) { (_) in
            self.result.text = "중지 버튼"
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        self.present(alert, animated: false)
    }
    
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID fover32@gmail.com의 암호를 입력하십시오"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            // 확인 버튼을 클릭했을 때 처리할 내용
            // 알림 메시지 창에 추가된 tf는 textFields 속성을 통해 참조할 수 있다.
            // 메시지 창에 추가할 수 있는 텍스트 필드 수는 여러 개이기 떄문에 textFields의 타입 또한 배열로 이루어져 있다.
            // alert.textFields?.first 도 가능
            if let tf = alert.textFields?[0] {
                print("입력된 값은 \(tf.text!)이다")
            }
            else {
                print("입력된 값이 없다")
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 패스워드를 비교하여 로그인을 처리해주고 싶으면 로그인을, 혹은 다른데 사용하고 싶다면 다른 곳에 사용해도 된다. 하지만 추가된 텍스트 필드에 아무런 설정도 추가하지 않을 생각이라면 confi~ 매개변수를 생략하고 호출 가능. 이 경우 위 예제의 구문은 다음과 같은 형식으로 바뀌게 된다.
        // alert.addTextField()
        alert.addTextField(configurationHandler: { (tf) in
            // 텍스트필드의 속성설정
            tf.placeholder = "암호" // 안내 메시지
            tf.isSecureTextEntry = true // 비밀번호 처리
        })
        
        self.present(alert, animated: false)
    }
    
    @IBAction func auth(_ sender: Any) {
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            // 확인 버튼을 클릭했을 떄 실행할 내용
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            
            if loginId == "fover32" && loginPw == "1234" {
                self.result.text = "로그인 성공"
            }
            else {
                self.result.text = "로그인 실패"
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // id field 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "아이디"
            tf.isSecureTextEntry = false
        })
        
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "비밀번호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: false)
    }
    
}

