//
//  EmployeeListVC.swift
//  Chapter06-HR
//
//  Created by G4ENG on 2020/06/15.
//  Copyright © 2020 G4ENG. All rights reserved.
//

import UIKit
class EmployeeListVC: UITableViewController {
    // 데이터 소스를 저장할 멤버 변수
    var empList: [EmployeeVO]!
    // SQLite 처리를 담당할 DAO 클래스
    var empDAO = EmployeeVO()
    
    func initUI() {
        // navTitle Label Set
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        nav
    }
}
