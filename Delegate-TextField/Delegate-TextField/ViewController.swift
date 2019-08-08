//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by G4ENG on 23/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// textfield delegate pattern
class ViewController: UIViewController{
    @IBOutlet var tf: UITextField!
    
    override func viewDidLoad() {
        // textfield feature setting
        self.tf.placeholder = "값을 입력하세요" // 안내 메시지
        self.tf.keyboardType = UIKeyboardType.alphabet // eng pad
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark  // dark
        self.tf.returnKeyType = UIReturnKeyType.join // return type join
        self.tf.enablesReturnKeyAutomatically = true // return key auto on
        
        // 스타일 설정
        self.tf.borderStyle = UITextField.BorderStyle.line  // 테두리 직선
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0)  // 배경색
        // UIColor 값으로 변환할 때는 사용하는 실수값은 다소 익숙하지 않는 부분이다. 구글 검색을 통해서 구할수 있다ㅓ http://uicolor.xyz
        self.tf.contentVerticalAlignment = .center  // 수직 방향으로 텍스트 가운데 정렬
        self.tf.contentHorizontalAlignment = .center // 수평 방향으로 가운데 정렬
        self.tf.layer.borderColor = UIColor.darkGray.cgColor    // 테두리 색상을 회색으로 -> 하위 객체인 layer 속성에 정의되어 있음.
        self.tf.layer.borderWidth = 2.0     // 테두리 두께
        // 텍스트 필드의 테두리 색상은 그보다 저수준에서 구현된 CGColor 타입의 값을 사용하기 때문에 UIColor 객체로 구현된 색상 정보를 CGColor 타입으로 변환해 주어야 한다. 다행히 바로 변환할 수 있도록 cgColor 속성을 제공하고 있으므로 이를 이용하면 됨\
        
        // textfield를 frist responder로 지정
        self.tf.becomeFirstResponder()
        
        // delegate 지정
        self.tf.delegate = self
        // 텍스트 필드의 delegate는 텍스트 필드에 특정 이벤트가 발생했을 때 알려줄 대상 객체를 가르키는 속성. 이 속성에 self는 현재의 뷰 컨트롤러 인스턴스를 의미.
    }
    
    @IBAction func confirm(_ sender: Any) {
        // textfield is canceled first resoponder
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        // text fild is made first responder
        self.tf.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    // 텍스트 필드의 편집이 시작된 후 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됨")
        return true // false를 리턴하면 편집되지 않음
    }
    
    // 텍스트 필드의 내용이 삭제될 떄
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됨")
        return true
    }
    
    // 텍스트 필드의 내요잉 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됨")
        if Int(string) == nil { // 입력된 값이 숫자가 아니면
            // 현재 텍스트 필드에 입력된 길이와 더해질 문자열 길이의 합이 10을 넘는다면 반영하지 않음
            if (textField.text?.count)! + string.count > 10 {
                return false
            }
            else {
                return true
            }
        }
        else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 편집 종료")
        return true
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됨")
        return true
    }
    
    // 텍스트 필드의 편집이 종료되었을 떄 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("편집 종료")
    }
    
}
