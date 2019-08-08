//
//  ViewController.swift
//  Scene-Trans01
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func moveNext(_ sender: Any) {
        /*
         // 이동할 뷰 컨트롤러 객체를 StoryborardID 정보를 이용하여 참조
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        */
        
        /*
        // UIStoryboard 초기화 과정에서 파일을 직접 지정
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // bundle -> 완성된 앱은 성격에 맞는 파일끼리 묶어 여러 개의 꾸러미를 만들어 내는데, 이 중에서 메인 번들은 앱의 주요 소스 코드 파일을 포함하고 있는 번들이다. -> 스토리보드 파일도 여기에 포함.
        let uvc = storyboard.instantiateViewController(withIdentifier: "SecondVC")
        */
        
        // self.storyboard는 옵셔널 값이다. 그래서 바인딩해주자 if문 보다는 vc는 메소드 전체 실행에서 비어 있어서는 안되는 필수 조건이기 때문에 guard가 적합하다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        // 화면 전환할 때의 애니메이션 -> 수직으로
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    
        self.present(uvc, animated: true)
    }
}
