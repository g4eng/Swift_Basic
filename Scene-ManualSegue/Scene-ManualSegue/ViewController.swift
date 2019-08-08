//
//  ViewController.swift
//  Scene-ManualSegue
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// 매뉴얼: 해당 이벤트만 발생하면 자동으로 실행되는 액션과는 반대로 뷰컨과 뷰컨 사이에 연결되는 수동 실행 세그웨이. 액션은 트리거의 터치에 의해 실행되므로 별도의 처리 코드가 전혀 필요 없지만, 매뉴얼은 트리거 없이 수동으로 실행해야 하므로 소스 코드에서 세그웨이를 실행할 때 호출해야 한다.
// performSegue(withIdentifier:, sender:)
// 두개의 인자값은 세그웨이가 여러 개일 경우를 대비한 세그웨이 식별자와 세그웨이를 실행하는 객체 정보.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func wind(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
    
}

