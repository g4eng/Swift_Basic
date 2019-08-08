//
//  ViewController.swift
//  HelloWorld
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// UIViewController라는 클래스를 상속받아서 ViewController라는 클래스를 서브클래싱한 것
class ViewController: UIViewController {

    // 아울렛 변수 UILabel!
    @IBOutlet var uiTitle: UILabel!
    
    // viewDidLoad는 UIViewController의 메소드여서 오버라이딩한다. 뷰의 로딩이 완료되었을 때 시스템의 의해 자동으로 호출됨.
    // 일반적으로 리소스를 초기화하거나 초기 화면을 구성하는 등, 처음 한 번만 실행해야 하는 초기화 코드는 대부분 이 메소드에 작성
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 부모 클래스에서 작성된 메소드의 내용도 모두 실행하다는 것.
    }
    // 콜백 메소드다.
    
    // Connection이 Outlet이냐 Action이냐에 따라 @IB~가 달라진다.
    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "Hello World!"
    }
}

