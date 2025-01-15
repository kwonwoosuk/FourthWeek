//
//  BlackRadiusLabel.swift
//  FourthWeek
//
//  Created by 권우석 on 1/15/25.
//

import UIKit

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    @available(*, unavailable) // baselabel 상속받은 친구는 더이상 required안 쓸거야 !!
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PointButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




protocol SeSAC {
    init() // 🔵
}

class Mentor :SeSAC{
    required init() { //🟣
        print("Mentor Init")
    }
}

class Jack: Mentor {
    required override init() { // 🔵
        super.init()
        print("Jack Init")
    }
}

class BlackRadiusLabel: BaseLabel {
    
    
    init(color: UIColor) {
        super.init(frame: .zero) // override를 하지않더라도 super만 호출하면 된다 !
        font = .boldSystemFont(ofSize: 15)
        textColor = color
        backgroundColor = .black
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
    }
    let a = Mentor() //🟣 프린트가 찍히겠다 ~
    // 코드베이스로 코드를 구성할때 호출되는 초기화 구문 = 스토리 보드로 구현할때 호출되는 awakeFromNib같은 기능
//    // 슈퍼클래스로 구현된 init
//    override init(frame: CGRect) {
//        
//        
//        
//        
//    }
    
    
    
    
    
    //  스토리보드로 구성할 때 호출되는 초기화 구문
    // 슈퍼클래스에 있는게 아니라 프로토콜에 구현 된 init이구나 ! => Required Initializer 라고 부른다 !
    // 실패가능한 이니셜라이저(Failable Initializer)
    required init?(coder: NSCoder) { // 프로토콜에 지정되어있다고 알려주고 싶은것 단지 그뿐 !
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
