//
//  ViewController.swift
//  Scene-CustomSegue
//
//  Created by G4ENG on 10/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// 앱을 제작하다 보면 기본적인 기능의 세그웨이로는 원하는 기능을 충분히 구현하기 어렵기 때문에 UIKit 프레임워크는 UIStoryboardSegue 클래스를 서브클래싱하여 새로운 기능을 갖춘 세그웨이 객체를 정의할 수 있도록 지원함. 이를 커스텀 세그웨이라 부름. 커스텀 세그웨이를 만들어보자
// 
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "custom_segue") {
            NSLog("custom_segue")
        }
        else if (segue.identifier == "action_segue") {
            NSLog("action_segue")
        }
        else {
            NSLog("unknown segue")
        }
    }
    // 전처리 메소드의 활용: 코드를 통홰 화면을 전환하는 방식은 구현하기 어렵고 상대적으로 난이도가 높지만 화면 전환 과정을 직접 제어할 수 있기 때문에 자유도가 높다. 그래서 프로그래머들이 선호 하는 방식. 반면에 세그웨이를 이용하면 난이도는 쉽지만 자유도 제한됨. 세그웨이를 이용하여 화면을 전환하는 과정에서 뭔가 특별한 처리를 해 주어야 할 때에는 어떻게 하면 될까? 다행히도 코코아 터치 프레임워크는 세그웨이가 실행되기 전에 특정한 메소드를 호출하도록 설계되었기 때문에, 이를 이용하면 화면을 전환하기 전에 필요한 처리를 해 줄 수 있다. 이를 전처리 메소드라 한다. 세그웨이를 실행하기 전에 값을 저장해둘 필요가 있거나, 혹은 경고창을 띄워주는 등의 처리를 해야 할 경우 전처리 메소드에 해당 내용을 작성해 놓으면 그 내용이 세그웨이가 실행되기 전에 자동으로 실행된다. 세그웨이를 실행하기 전, 준비 작업의 의미로 실행되는 전처리 메소드의 정체는 다음과 같다.
    // prepae(for segue: UIStoryboardSegue, sender: Any?) { ... }
    // 주의할 점은 호출 주체다. 이 메소드의 호출 주체는 우리가 아니다. 우리가 구현해 놓으면 시스템이 호출하는 방식. 필요한 시점에. 이는 곧 우리가 호출하고 싶을 때 임의로 호출할 수 없다는 뜻. 패시브 스킬 같은거다. 이 메소드는 segue를 받는 첫 번째 매개변수, -> 일반적으로 뷰컨에 연결된 세그웨이는 여러 개가 될 수 있는데,. 이들 세그웨이는 모두 실행 전에 전처리 메소드를 공통적으로 호출하낟. 하나의 전처리 메소드를 여러 세그웨이가 공유하는 방식. 이 떄문에 전처리 메소드는 어느 세그웨이가 자신을 호출한 것인지를 알고 구분해 주어야 한다. 그에 대한 정보가 첫 번째 매개변수를 통해 전달됨.
    // 두번쨰 매개변수 트리거에 대한 정보. -> 액션이라면 버튼이나 테이블 셀, 혹은 제스처. 매뉴얼 이라면 뷰컨 자신이 인자값으로 전달됨.
    // 전처리 메소드는 UIViewController 클래스에 이미 정의되어 있다. 우리가 이 메소드를 작성한다는 것은 오버라이딩이다.
}

