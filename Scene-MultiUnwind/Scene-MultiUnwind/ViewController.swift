//
//  ViewController.swift
//  Scene-MultiUnwind
//
//  Created by G4ENG on 10/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// unwind segue를 이용하여 한꺼번에 여러 페이지 복귀하기: iOS는 앱 내부에서 뒤로 가기 버튼을 만들어 주어야한다. 내비게이션 컨트롤러를 사용하지 않으면 앱일 때 뒤로가기 버튼마저 없으면 되돌아갈 방법이 없기 때문에 앱 사용성이 심각한 결함 수준에 이르기도 한다.
// 그런데 실제로 사용되는 앱은 우리가 만들어 본 것처럼 화면이 단 두개로 연결되는 것이 아니라 여러 페이지에 걸쳐 단계적으로 이동하는 경우가 많다. 여러 페이지를 단계적으로 이동한 경우 가장 첫 화면, 즉 홈으로 돌아가려면 어떻게 해야 할까? 그리고 만약 중간에 있던 화면으로 돌아가려면 어떻게 해야할까? 이것도 어렵지 않다. 앞에서와 마찬가지로 돌아가고자 하는 뷰컨에 이정표 역할을 하는 메소드를 만들어준 다음, exit 아이콘을 통해 버튼과 연결하면 된다.
// 앱 프로젝트 전역에서 구분 가능한 유일하고 구체적인 이름으로 작성해주자, 인자값으로 UIStoryboardSegue 객체를 받아야 한다. 외부 매개변수명은 언더바로 처리하여 호출 시에 인자 레이블을 사용하지 않도록 처리해주자.
// 네번째 화면에서 곧 바로 두번째 화면으로 되돌아가는 기능을 구현해보자. unwind segue가 향할 대상이 page2이므로 page2 뷰컨에 메소드를 추가하면 된다.
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoPage1(_ sender: UIStoryboardSegue) {
        
    }

}

