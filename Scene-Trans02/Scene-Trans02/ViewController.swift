//
//  ViewController.swift
//  Scene-Trans02
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// 내비게이션 컨트롤러를 추가하였다 하더라도 사용하지 않고 다른 방법으로 화면을 전환하면 두번재 뷰컨에는 내비게이션 바가 추가되지 않는다. -> 내비게이션 컨트롤러의 제어하에 있지 않기 때문. 동일한 뷰컨임에도 화면 전환 방식에 따라 상태가 달라져서 내비게이션 컨트롤러의 제어하에 놓이기도 하고 그렇지 않기도 하기 때문.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveByNavi(_ sender: Any) {
        // 두번째 뷰 컨트롤러 인스턴스 생성, 앞에 내용과 비슷하게 가드문을 이용해서 옵셔널체인을 이용하여 객체 생성
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        // 화면 전환 -> 네비게이션 컨트롤러에서 pushViewController(_:animated:)는 기술적 관점에서 내비게이션 스택 최상위에 뷰 컨트롤러 객체 uvc를 추가하는 것이지만, 사용자들에게는 화면 전환 효과를 준다. 유의할 점은 메소드를 호출하는 대상. 이전에 사용했던 present(_:animated:)는 뷰컨트롤러 자신을 대상으로 호출하는 것이었던 반면, push~는 호출하는 대상이 내비게이션 컨트롤러, 즉, self.navigationController는 현재의 뷰 컨트롤러에 연결된 내비게이션 컨트롤러를 가리키는 것. 만약 뷰컨에 내비컨트롤러가 연결되어 있지 않을 경우 nil값을 반환.
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    @IBAction func movePresent(_ sender: Any) {
        // 두번재 뷰컨 인스턴스 생성
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        // 화면 전환
        self.present(uvc,animated: true)
    }
}

