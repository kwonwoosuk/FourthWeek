//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire


protocol ViewConfiguration: AnyObject { // 클래스에서만 사용가능하도록 anyobject 클래스의 인스턴스만 들어올 수 있음
    func configureHierarchy() // addSubView
    func configureLayout()  //snapKit
    func configureView() // property
}
struct Dog: Decodable { // 외부의 데이터를 역직렬화할 수 있는 프로코톨을 갖고있어야해
    let message: String
    let status : String
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
    
}

struct User: Decodable {
    let results: [UserDetail]
    //let info:
}

struct UserDetail: Decodable { // 순차 적으로 같은 뎊스에 맞기 구조체를 잘 가져다 주어야 사용하능하다
    let gender: String
    let email: String
    let name: UserName
}

struct UserName: Decodable {
    let first: String
    let last: String
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
        randomButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        print("========1========")
        //버튼 누르면 랜덤으로 강아지
        // 크롬에서 엔터 칠때처러 ㅁ요청하는 부분
        let url = "https://dog.ceo/api/breeds/image/random"
        // responseDecodable: 응답이 잘못된것도 실패고 식판에 안담겨도 실패
        //responseString: 식판이랑 상관없이 응답이 잘 왔는지 확인
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            print("======2======")
            switch response.result {
                
            case .success(let value): // 응답, 식판 => 구조체를 활용할 수 있다.
                print(value.drwNoDate)
                print(value.firstWinamnt)
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
                
            case .failure(let error):
                print(error)
            }
            print("========3========")
        }
        
        print("========4=========")
        
        
    }
    
    
    @objc
    func lottoButtonTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(Int.random(in: 800...1154))"
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            print("======2======")
            switch response.result {
                
            case .success(let value): // 응답, 식판 => 구조체를 활용할 수 있다.
                print(value.drwNoDate)
                print(value.firstWinamnt)
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
                
            case .failure(let error):
                print(error)
            }
            print("========3========")
        }
        
        
        // .responseString { value in 1단계
        //print(value)
    }
    @objc
    func userButtonTapped() {
        //
    }
}

