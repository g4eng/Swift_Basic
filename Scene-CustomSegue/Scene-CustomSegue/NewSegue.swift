//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by G4ENG on 10/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

// 세그웨이는 양쪽 뷰컨 사이를 한쪽 방향으로 연결하는 개체기 때무넹 항상 출발지, 목적지에 해당하는 뷰컨을 가진다. 이들 각각은 다음과 같은 속성을 사용하여 읽어올 수 있다. 읽어온 속성의 타입은 UIViewController다.
// 출발지: self.source, 도착지: self.destination
// 출발지와 목적지의 뷰컨인스턴스를 읽어왔따면, 이를 이용하여 양쪽 사이의 화면 전환 방식을 정의해주면 된다. 각자 구현하는 커스텀 세그에 따라 전환 방식이 달라지는데, 예제에서 구현하고 있는 것은 UIView 객체의 전환 기능을 사용하는 방법이다. UIView.transition(from:to:duration:options:)은 타입메소드다. 이 메소드는 모두 네 개의 인자값을 가지는데, 각각 다음과 같다. 출발지뷰, 도착지뷰, 화면 전환에 걸리는 시간, 애니메이션 전환 옵션. 이 메소드에 적절한 인자값을 넣어주면 커스텀 세그웨이가 실행될 때 perform()이 호출되면서 출발지 뷰컨의 뷰를 목적지 뷰컨의 뷰로 대체한다. 만약 화면 전환이 완전히 끝난 후 뭔가 처리할 내용이 있다면, completion: 매개변수를 추가해서 사용하면 된다.
// 우리가 구현하고자 하는 커스텀 세그웨이는 화면 전환 시 뷰컨 전체를 전환하는 대신, 다른 컨트롤러에 있는 뷰만 읽어와 전환하는 세그웨이다. 이를 으용하면 뷰컨 하나에서 상태값에 따라 여러 가지 다른 뷰를 다양하게 표현하는 일이 가능하다.

class NewSegue: UIStoryboardSegue {
    
    override func perform() {
        // 세그웨이의 출발지 뷰 컨트롤러
        let srcUVC = self.source
        // 세그웨이의 목적지 뷰컨
        let destUVC = self.destination
        // fromView에서 toView로 뷰를 전환한다.
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
    }
}
