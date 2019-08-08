//
//  ViewController.swift
//  Msg-Notification
//
//  Created by G4ENG on 19/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet var msg: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        if #available(iOS 10, *) {
            // UserNoticiation 프레임워크
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    // 알림 설정이 들어갈 곳
                    // ↓ 이 코드는 백그라운데서 실행되는 로직을 메인 쓰레드에서 실행되도록 처리해주는 역할
                    // iOS의 프로그램 실행 영역은 UI 등의 주요 처리를 담당하는 메인 실행 영역과 그리 중요하지 않은 처리를 담당하는 백그라운드 실행 영역으로 나누어지는데, 대부분의 비동기 클로저가 구문은 백그라운드 실행 영역에서 처리됨. 문제는 UI 처리는 모두 메인 실행 영역에서 이루어져야 한다는 것이다. 이 때 메인 실행 영역에서 처리되어야 하는 부분을 해당 구문으로 감싸주면, 그 범위 내의 코드는 모두 메인 실행 영역에서 수행됨.
                    DispatchQueue.main.async {
                        
                        // 알림 컨텐츠 정의
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        // 메시지 본문에 들어갈 내용을 사용자가 텍스트 필드에 입력한 값으로 처리
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default
                        
                        // 발송 시각을 *초 형식으로 변환
                        let time = self.datePicker.date.timeIntervalSinceNow
                        // 데이트 피커를 사용하여 설정한 시각은 datePicker 객체의 date 속성을 통해 참조 가능, 이 값의 타입은 Date 클래스이다. 하지만 우리가 사용할 UNTimeIntervalNotificationTrigger 객체는 *초 뒤의 형식이기 때문에 적절히 변경해 주어야 한다.
                        // 이를 위해 Date 클래스에서 제공되는 timeIntervalSinceNow 속성을 사용하여 계산함
                        // 발송 조건 정의
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        // 발송 요청 객체 정의
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                        
                        // 노티센터에 추가
                        // add의 두번째 매개변수는 완료 시 호출될 클로저를 입력할 수 있음. 이를 트레일링 클로저 형식으로 메시지창을 호출하도록 내용을 작성하자.
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                // 발송 완료 안내 메시지 창
                                let date = self.datePicker.date.addingTimeInterval(9*60*60)
                                // 날짜 시각으로 표현하면 GMT, 즉 세계 표준시를 기준으로 보여주게 된다. 그러나 우리가 설정한 시각은 우니라라에 맞게 보여주려면 여기에 9시간을 더해주어야 한다. 이를 위해서 addingTimeInterval(_:)를 사용하는데, 원하는 시간만큼 더해서 표현할 수 있다. 입력값의 단위는 초이므로 9시간을 더해서 표현하려면 시간*분*초 (9*60*60)으로 표현
                                let message = "알림이 등록되었습니다. 등록된 알림은 \(date)에 발송됨"
                                let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                                alert.addAction(ok)
                                
                                self.present(alert, animated: false)
                            }
                        }
                    }
                }
                else {
                    let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되지 않았습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    return
                }
            }
        }
        else {
            // localNotification 객체 이용
        }
    }
    
}

