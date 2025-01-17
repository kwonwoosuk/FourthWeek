//
//  UserDefaultsManager.swift
//  FourthWeek
//
//  Created by 권우석 on 1/16/25.
//

import UIKit

class UserDefaultsManager { //
    
    
    // 다른외부에서 UserDefaultsManager공간을 만들지 않고 하나의 공간에서만 쓰겠다! 라는 의미를 내포하고 있다.
    static let shared = UserDefaultsManager() // 인스턴스가 매번 모든 컨트롤러에서 인스턴스로 생성되는것이 아니라 static으로 선언해서 사라지지 않는 녀석으로 만들어준다
    
    private init() {}  // 다른곳에서 신경쓰면서 안써야하는게 아니라 이렇게 private로 이니셜라이저를 선언하게되면 다른곳에서 선언조차 할 수 없게된다.
    // 인스턴스를 생성할 일이 없는 친구라고 생각되면 Private으로 생성해줘서 코드를 더 안정적으로 돌아가도록 해준다.
    // shared로 쓰겠다는 개념자체 -> 싱글톤패턴 ⭐️  왜 안티패턴이라고도 불리는지?
    // 많은 사람들이 쓰다보니까 생긴게 패턴이라고 생각해서 무슨 패턴을 알아봐야겠다! 오늘은 뭐 해봐야지 보다 , 불편함을 느껴서 만들다보니 그 플로우가 그 패턴임을 알고, 어떤상황에 쓰고싶고 왜 필요한지 알아가는게 더 중요하다고 생각. 해야해서 하는게 아닌 하다보니 하는?
    
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
}
