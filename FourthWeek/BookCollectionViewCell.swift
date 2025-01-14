//
//  BookCollectionViewCell.swift
//  FourthWeek
//
//  Created by 권우석 on 1/13/25.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    let bookCoverImageView = UIImageView()
    
    // 코드베이스로 구성할때 레이아웃은 어디서?  viewdidload와 비슷 | 스토리보드 기준 awakeFromNib과 비슷하다고 생각하면 될 것 가타요
    override init(frame: CGRect) {
        super.init(frame: frame)
        //셀에는 contentView가 존재 한다 !!! 여기에다가 뷰를 추가해야 액션이 동작합니다 ⭐️⭐️⭐️⭐️⭐️ (클릭)
        contentView.addSubview(bookCoverImageView)
        
        bookCoverImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide) //  모양이 다르지만 safeArea기준으로 잡아주는건 같다
        }
        bookCoverImageView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) { //  쓰라고 엑코가 그래서 썼다요 14일에 풀어주신다고 하셨어요
        fatalError("init(coder:) has not been implemented")
    }
}
