//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 이 메솓는 앱이 처음 실행될 때, 필ㅇ한 시스템적 처리를 모두 끝내고 메인 화면을 표시하기 직전에 호출됨. 다시 말해, 앱이 맨 처음 실행될 때 시작 화면이 모바일 기기의 스크린에 표시된 후 이 메소드가 호출되고, 이 메소드 내부에 작성된 내용이 모두 실행되고 나면 우리가 앞에서 구현한 Main이 표시됨. 이 메소드에 sleep(5)를 추가해보자
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 이 부분은 프로세스의 진행을 멈춰 시작 화면이 표시되는 시간을 늘려주는 역할
        sleep(5)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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


}

