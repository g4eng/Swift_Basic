//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by G4ENG on 24/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        // 델리게이트 지정
        picker.delegate = self
        
        // 피커 실행
        self.present(picker, animated: false)
    }
}

// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
// 익스텐션은 클래스를 대신해서 프로토콜을 구현할 수 있기 때문에, 델리게이트 패턴에 사용되는 프로토콜을 익스텐션에서 구현하면 하나의 뷰 컨트롤러 클래스에 여러 프로토콜 메소드가 난립하는 것을 방지할 수 있다.
extension ViewController: UIImagePickerControllerDelegate {
    
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 떄 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커에서 이미지를 선택하기 않고 취소했을 때 호출되는 메소드
        
        // 왜 picker.presentingViewController?.dismiss를 안씀?
        // 어짜피 가리키는 대상이 자기 자신이므로 self써도 무방.
        // 하지만 picker를 쓴건 self.presentingViewController쪽으로 알아서 연결시켜줌
        picker.dismiss(animated: false) { () in
            // 알림창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소됨", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        }
        // 충돌을 피하고자 dismiss 끝나고 할 행동을 completion 매개변수에 클로저로 넣어준다
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 피커에서 이미지를 선택했을 떄 호출되는 메소드
        
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지뷰에 복사
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            // 딕셔터리 타입으로 정의된 매개변수 info에는 사용자가 선택한 이미지 정보가 담겨서 전달되기 때문에, 앞에서 살펴본 이미지 관련 키를 사용해서 원하는 이미지 정보를 추출. 위에서 사용하고 있는 것은 편집된 이미지 데이터다. 이를 위해 UIImagePickerControllerEditedImage 상수값이 사용됨
            // 읽어온 값은 이미지 데이터를 담고 있지만 아직 범용 객체인 Any 타입이다. 따라서 UIImage로 다운캐스팅해야 사용 가능
            self.imgView.image = img
        }
    }
}

// MARK:- 내비게이션 컨트롤러 델리게이트 메소드
// 모든 프로토콜을 반드시 하나의 익스텐션에 담을 필요는 없다. 하나의 익스텐션이 하나의 프로토콜만 처리하도록 다음과 같이 코드를 작성하면 훨씬 더 깔끔하게 코딩 가능
extension ViewController: UINavigationControllerDelegate {
    
}
