//
//  BaseView.swift
//  FourthWeek
//
//  Created by 권우석 on 1/16/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {} //  프린트 넣어서 base가 먼저 실행되는지 bookview가 먼저 실행되는지 알아보자 !
    
    func configureLayout() {}
    
    func configureView() {}
    
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

