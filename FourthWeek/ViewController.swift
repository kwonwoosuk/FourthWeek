//
//  ViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/13/25.
//


import UIKit
import SnapKit

/**
 기존 순서
 1. 스토리보드에 객체 얹기
 2. 객체 레이아웃 잡기
 3. 아웃렛 연결하기
 4. 객체 속성 코드로 조절하기
 */
// Right To Left, Left To Right

// leading 과 trailing을 사용하는 경우 - 글로벌 대응!
class ViewController: UIViewController {
    
    // 1. 뷰 객체 프로퍼티 선언
    let emailTextField = UITextField() // 아웃렛 연결 대신에 클래스 인스턴스를 생성해서 변수에 대입합니다.
    
    let passwordTextField = UITextField()
    
    let nameTextField = UITextField()
    
    let redview = UIView()
    let greenview = UIView()
    let grayview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
        frameBasedLayout()
        layoutAnchor()
        //autoLayoutSnapKit()
        autoLayoutSnapKit2()
    }
    // MARK: - autoLayout2
    func autoLayoutSnapKit2() {
        view.addSubview(redview)
        view.addSubview(grayview)
        redview.addSubview(greenview)
        
        redview.backgroundColor = .red
        grayview.backgroundColor = .gray
        greenview.backgroundColor = .green
        
        redview.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        grayview.snp.makeConstraints { make in
            make.edges.equalTo(redview).inset(50)
        }
        
        greenview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    
    
    // MARK: - autoLayout -- SnapKit
    func autoLayoutSnapKit() {
        view.addSubview(redview) //⭐️
        view.addSubview(greenview) //⭐️
        
        view.addSubview(grayview)

        redview.backgroundColor = .red
        greenview.backgroundColor = .green
        grayview.backgroundColor = .gray
        
        redview.snp.makeConstraints { make in
//            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
//            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50) // 안쪽으로 50띄워줍니다 위에 두줄과 같은 의미를 갖습니다
            
            
            //1. 2단계 합침 make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            //make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            // 1. 2단계합침 make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            //make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            // hori 랑 verti도 합치면 그냥 edges로 사용가능
            
            //3 단계 합침
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50) // 안쪽으로 50띄워줍니다
        }
        
        greenview.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide) // 중앙에 위치시킬거면 합칠수 있다
            //make.centerY.equalTo(view.safeAreaLayoutGuide)
            //make.center.equalTo(view.safeAreaLayoutGuide) 최종으로 합친 모습
            make.width.height.equalTo(200) // 높이와 너비가 같으면 두가지 옵션을 동시에 줄 수도 있다 !
            //make.size.equalTo(300) 심지어 이렇게도 쓸 수 있다.
        }
        grayview.snp.makeConstraints { make in
            make.top.equalTo(greenview.snp.bottom).offset(50)// 그린뷰의 바텀이랑 그레이뷰의 탑이랑 같아! .똑같긴한데 offset을 통해서 거기거 몇 만큼 띄우고 시퍼
            make.centerX.equalTo(greenview.snp.centerX).offset(-100)
            make.size.equalTo(200)
        }
        
        
        
        
    }
    
    
    
    func frameBasedLayout() {
        // 2. addSubView로 해당 뷰를 추가
        view.addSubview(emailTextField)
        
        
        // 3. 레이아웃(위치와 크기) 설정
        //기기 width 393 (16기준) 이니까, 오른쪽으로 50주고, 너비를 293넣으면 중간에 정렬이 되겠구나!  -> 프레임 베이스
        emailTextField.frame = CGRect(x: 50, y: 100, width: 300, height: 100)
        
        // 4. 뷰 속성 조절
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .red
    }
    
    // iPhone 5 때 나왔습니다. => auto resizing 이라는게 이전에 있었습니다.
    func autoLayout() {
        // Auto Layout
        view.addSubview(passwordTextField)
        // addSubView 없이, 하면 런타임에러가나고, illegal하다고 합니다. => 에러 캡처해보기!
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false // <- 오토리사이징 VS 오토레이아웃 중 하나만 설정해야하는데, 스토리보드에서 자동으로 해줘야하는 것을 코드베이스에서는 이를 명시적으로 설정해줘야합니다. // 흐린눈과 까막눈 ! 아악! 이거 왜이래! 오 이렇구나 ! 에 대한 이해는 같은 현상에 대해서 무지를 선택하는가, 이해를 선택하는가
        // 예전에는 뭐야, 그건 나도 알지 그거 설명할라고그런거야? 나는 이거를 한채로 하고싶다구! 라고 대응했었다.
        
        
        // Constraint 하나 만들기.
        //         이거 프로토콜로 만들면 편할듯
        let topConstraint = NSLayoutConstraint(item: passwordTextField,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide, // safeLayoutGuide 를
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 50)
        
        let leadingConstraint = NSLayoutConstraint(item: passwordTextField,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view.safeAreaLayoutGuide,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 50)
        
        let heightConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        
        
        let centerAlignmentConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
        
        view.addConstraints([topConstraint, leadingConstraint, heightConstraint, centerAlignmentConstraint])
        passwordTextField.backgroundColor = .blue
        passwordTextField.placeholder = "Password"
        
        
        
    }
    func layoutAnchor() {
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        nameTextField.backgroundColor = .green
    }
}

