//
//  BookViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/13/25.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    
    var mainView = BookView()
    
     
    
    // super 절대 호출 금지 : 애플이 갖고 있는 뷰를 다시 호출하면 내것으로 못 바꿀 수 있다
    override func loadView() {
        view = mainView
    }
    // 검색키워드 tableView programmingly
    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = UserDefaultsManager()
        ud.age = 70
        UserDefaultsManager.shared.age
        
        
        
    }
}
