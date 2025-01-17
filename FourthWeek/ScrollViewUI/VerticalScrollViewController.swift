//
//  VerticalScrollViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/17/25.
//

import UIKit
import SnapKit
// 생각보다 많이 쓰일 수 있음
class VerticalScrollViewController: UIViewController {
    
    
    let scrollView = UIScrollView() //  스크롤뷰가 뷰 하나만 관리할 수 있도록
    let contentView = UIView()
    // con
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)// 스크롤뷰에는 컨텐츠 뷰만 담고 컨텐츠 뷰에서 imageview, label,button 관리
        
        configureLayout()
        configureContentView()
    }
    
    func configureLayout() {
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.backgroundColor = .red
        contentView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)// 스크롤 뷰와 너비가 같아야함 -> 수직 스크롤
            make.verticalEdges.equalTo(scrollView) // 가로 하고싶다 Hori / height을 똑같이 잡아유
        }
    }
    func configureContentView() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        
        
        
        label.backgroundColor = .orange
        imageView.backgroundColor = .black
        button.backgroundColor = .purple
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(900)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(label.snp.bottom).offset(50)
            make.bottom.equalTo(imageView.snp.top).offset(-50)
        }
    }
}
