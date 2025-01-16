//
//  BaseTableViewCell.swift
//  FourthWeek
//
//  Created by 권우석 on 1/16/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    
    func configureLayout() {}
    
    func configureView() {}
    
    @available(*, unavailable) //  앞으로 다신 보지 말자아?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
