//
//  ViewController.swift
//  Scene-UnwindSegue
//
//  Created by G4ENG on 10/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

// 지금까지 화면 전환을 설명하면서 이전 화면으로 되돌아가는 것을 '복귀' 등 여러가지 말로 표현했지만, 사실 이에 대한 공식 용어는 Unwind이다. 새로운 화면으로 전환하는 것을 Wind라 하고, unwind는 wind 작업을 해제한다는 의미로 볼 수 있다. 다시 말해, 새로운 화면을 해제하고 본래의 화면으로 돌아간다는 해석이다.

// unwind는 어떤 식으로 구현하면 될까 우선 생각해 볼 수 있는 것으로 앞에서 이미 배운 화면 복귀용 메소드를 이용하는 방법이 있다. 세그웨이를 이용한 화면 전환이라 할지라도 그 원리는 소스 코드에서 화면 전환용 메소드를 호출하여 화면을 전환하는 것과 동일함. 그러니, 화면 복귀용 메소드를 사용하면 세그웨이를 이용한 화면 전환을 unwind 처리할 수 있다.
// 프레젠테이션 방식으로 이동했을 때: dismiss(animated:)
// 내비게이션 컨트롤러를 이용하여 이동했을 떄: popViewController(animated:)
// 또 다른 방법은 세그웨이 구조에서 제공하는 이른바 unwind segue를 이용하는 것. 스토리보드 뷰컨 상단에 나타나는 도크 바의 아이콘 중에서 세 번째 아이콘에 올려보면 exit 툴팁이 표시되는데, 이를 이용하여 현재 화면을 종료하고 이전 화면으로 되돌아가는 unwind segue를 구현할 수 있다. -> 화면 복귀에 사용할 버튼을 만들고 이 버튼을 Exit 아이콘에 드래그하여 트리거를 생성하거나 또는 수동으로 실행되는 unwind segue를 만들어 호출하면 간단하게 생성 가능. 뷰컨 A에서 뷰컨 B로 화면을 이동했다고 할 때, 다시 원래의 뷰 컨A로 되돌아가기 위한 unwind segueway의 구현 방법은 다음과 같다.
// 1. 뷰컨A에 UIStoryboardSegue 타입의 인자값을 받는 @IBAction 액션 메소드를 정의한다. 이를 Unwind segue 메소드라 부른다. 이떄 메소드를 버튼과 연결할 필요는 없다.
// 2. 뷰컨B에 버튼을 만들고 이를 exit 아이콘에 드래그한다. 트리거를 생성하는 것
// 3. 버튼이 드래그된 exit 아이콘은 1에서 생성한 메소드를 인식하고, 이를 찾아 unwind segue로 자동생성해 준다.
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToVC(_ segue: UIStoryboardSegue) {
        
    }
    // 코코아 터치 시스템은 앱 내부에 정의된 모든 메소드를 스캔하여, 이 중에서 UIStoryboard 타입의 인자값을 입력받는 액션 메소드를 모두 수집한다. 그리고 exit 아이콘의 목록을 출력한다. 우리가 이 중 하나를 선택하여 연결하면, 해당 메소드가 정의된 뷰컨으로 돌아가는 unwind 메소드가 만들어진다. 우리가 작성한 unwindToVC(_:) 메소드는 말하지면 현재 화면을 종료했을 때 어느 화면으로 이동할지 여부를 알기 위한 이정표 역할인 거다. -> 이정표 메소드라고 부르자
    // 지금은 뷰컨이 두개여서 역할을 이해하기 어려울 수 있다.

}

