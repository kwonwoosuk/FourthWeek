//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/14/25.
//

import UIKit
import SnapKit

protocol ViewConfiguration: AnyObject { // 클래스에서만 사용가능하도록 anyobject 클래스의 인스턴스만 들어올 수 있음
    func configureHierarchy() // addSubView
    func configureLayout()  //snapKit
    func configureView() // property
}


class RandomViewController: UIViewController, ViewConfiguration {
    

    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    let randomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    
    func configureHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configureLayout() {
        dogImageView.snp.makeConstraints { make in
                    make.size.equalTo(300)
                    make.centerX.equalToSuperview()
                    make.top.equalTo(view.safeAreaLayoutGuide)
                }
                
                nameLabel.snp.makeConstraints { make in
                    make.width.equalTo(300)
                    make.height.equalTo(50)
                    make.centerX.equalToSuperview()
                    make.top.equalTo(dogImageView.snp.bottom).offset(20)
                }
                
                randomButton.snp.makeConstraints { make in
                    make.width.equalTo(300)
                    make.height.equalTo(50)
                    make.centerX.equalToSuperview()
                    make.top.equalTo(nameLabel.snp.bottom).offset(20)
                }
        
    }
    
    func configureView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        randomButton.backgroundColor = .brown
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        print(#function)
    }
    
    
    
    


}
