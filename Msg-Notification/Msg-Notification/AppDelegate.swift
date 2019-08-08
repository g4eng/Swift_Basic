//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by G4ENG on 19/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            notiCenter.delegate = self // 추가된 부분 -> 앱 델리게이트 클래스는 사용자가 알림 메시지를 클릭하는 이벤트를 전달 받을 수 있다. -> 델리게이트 패턴 구조 덕분
            // 알림 센터와 관련하여 뭔가 사건이 발생하면 나한테 알려줘
            // 메시지 클릭 이벤트를 앱 델리게이트 클래스가 감지할 수 있도록 했을 뿐, 이벤트를 어디서 받아서 어떻게 처리할지는 정의하지 않았다.
            // 앱이 실행되는 도중에 알림 메시지가 도착할 경우 userNotificationCenter(_:willPresent:withCom~:)가 자동으로 호출된다. 따라서 이 메소드를 구현하면 우리는 앱 실행 도중에 알림 메시지가 도착했는지를 알 수 있으며, 원한다면 알림 배너를 띄워줄 수도 있다. 반대로 이 메소드를 구현하지 안흥면 앱 실행 도중에 도착한 알림은 배너 형태로 표시되지 않으므로, 앱 실행 중에도 알림 배너를 표시해 주고 싶다면 해상 메소드를 구현한다. 또한 사용자가 알림 메시지를 실제로 클릭하면 userNotificationCenter(_:didReceive:withCom~)가 자동으로 호출됩니다. 앱이 실행되는 중이던 미실행 상태이던 상관없이 동일하게 말이다. 따라서 우리는 앱 델리게이트 클래스에다 각각의 경우에 맞게 해당 메소드를 구현해 놓으면 된다
        }
        else {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성, 이를 애플리케이션에 저장
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            // 사용할 알림 환경, 생성된 알림 정보를 애플리케이션에 등록해주어야 하는데, registerUsernotificationSetting()가 사용됨. 이 메소드는 UIApplication 객체에 정의되어 있는데, 알림 설정 정보를 인자값으로 하여 호출하면 애플리케이션에 등록됨. 이 과정에서 사용자 동의가 필요하기 때문에, 실제로 사용자에게 동의 여부 창이 표시되는 시점은 이 메소드가 호출될 때.
            application.registerUserNotificationSettings(setting)
            // UIApplication은 앱 애플리케이션 자체를 의미하는 객체로, 싱글턴 패턴으로 설게됨. 이들은 유일한 인스턴스를 참조하기 위한 저마다의 방법을 제공함. 애플리케이션 객체의 경우 .shared를 사용하여 가능 하지만 우리는 메소드의 첫번째 매개변수를 통해 참조하기 때문에 이처럼 사용 가능.
            
            if let localNoti = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification {
                // 알림으로 인해 앱이 실행된 경우
                print((localNoti.userInfo?["name"])!)
            }
            // 메시지를 눌러 앱을 실행헀다면 매개변수 launchOptions에는 UIApplication.launchop~ 키와 그에 해당하는 값이 저장됨. 이를 이용하면 알림을 눌러 앱을 실행했는지 여부를 쉽게 판별 가능. 참고로 launchOptions는 딕셔너리 타입의 매개변수다. 알림을 발송할 때 userInfo 속성에 저장했던 값을 위 키를 이용하여 받은 값을 통해 다시 읽어 들일 수 있으므로 이를 이용하면 알림 메시지 종류에 따라 개별적인 로직을 처리해 줄 수도 있다.
            // 앱 델리게이트의 위 메소드에서 해당 키에 값이 넣은 채로 전달되는 경우는 앞에서 설명한 세 가지 알림 관력 액션을 취했을 때뿐이다. 앱 아이콘에 배지가 설정되어 있는 상태에서 앱 아이콘을 클릭하면 이때에도 해당 값이 함께 전달된 것으로 기대하는 분들이 종종 있는데, 앱 아이콘을 클릭하여 실행하는 경우에는 배지가 설정되어 있더라도 알림 액션과는 무관한 실행으로 간주된다. 따라서 위 코드의 noti 상수값은 nil이다
            // 앱이 실행 중인 상태에서 알림이 도착한다면 비/활성화 상태와 관계없이 앱 델리게이트의 application(_:didReceive:)가 호출됨. 이때 알림 객체 정보도 함께 전달되므로 userInfo 속성에 저장된 값을 참고하여 원하는 액션을 처리해 줄 수 있다. 비활성화 상태에서 알림이 도착한다면 이 알림을 클릭했을 때 해당 메소드가 실행되지만, 활성화 상태일 때에는 화면에 알림 메시지가 표시되지 않아도 해당 메소드는
        }
        return true
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print((notification.userInfo?["name"]))
        if application.applicationState == UIApplication.State.active {
            // 앱이 활성화 된 상태일 때 실행할 로직
        }
        else if application.applicationState == .inactive {
            // 앱이 비활성화된 상태일 때 실행할 로직
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        if #available(iOS 10.0, *) {    // UserNotofication framework를 이용한 로컬 알림 (iOS 10 이상)
            // 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings{ settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    // 알림 콘텐츠 객체
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!"
                    nContent.body = "앗! 왜 나갔어요??? 어서 들어오세요!"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name":"홍길동"]
                    
                    // 알림 발송 조건 객체
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    // 알림 요청 객체
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    
                    // notifaction center에 추가
                    UNUserNotificationCenter.current().add(request)
                }
                else {
                    print("사용자가 동의하지않음")
                }
            }
        }
        else {  // UILocalNotification 객체를 이용한 로컬 알림 (iOS 9 이하)
            let setting = application.currentUserNotificationSettings
            
            // 알림 설정이 되어 있지 않다면 로컬 알림을 보내도 받을 수 없으므로 종료함
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            
            // 로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) // 10초 후
            noti.timeZone = TimeZone.autoupdatingCurrent    // 현재 위치에 따라 타임 존 설정
            noti.alertBody = "얼른 다시 접속하세요!!!"
            noti.alertAction = "학습하기"
            noti.applicationIconBadgeNumber = 1
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.userInfo = ["name":"홍길동"]
            
            // 스케줄러에 등록
            application.scheduleLocalNotification(noti)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 앱 실행 도중에 알림 메시지가 도착한 경우
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        // 알림 배너 띄워주기
        completionHandler([.alert, .badge, .sound])
    }
    // 앱이 실행 중인 상태에서 알림 메시지가 도착하면, 알림 배너의 표시 여부와 상관없이 이 메소드가 호출된다. 만약 필요한 전처리가 있다면 이를 수행한 후, 예제의 맨 마지막에 작성된 completionHandler()를 반드시 호출해주어야 한다. 이를 생략하면 앱 실행 도중에 알림 배너는 표시되지 않는다. 당연히 이어지는 step 4의 메소드도 호출되지 앟ㄴ는다.
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ _center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler()
    }
    // 이 메소드는 실제로 사용자가 알림 메시지를 클릭했을 경우에 실행된다는 차이를 가짐. 따라서 알림 메시지를 클릭하여 들어온 사용자에게 뭔가 특별한 경험을 제공하고 싶다면, 이 메소드 내에 원하는 코드를 작성하면 된다. 이때 알림 메시지에 대한 정보는 모두 위 메소드의 두 번째 인자값인 response 매개변수에 담겨 전달됨

}

