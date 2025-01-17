//
//  ImageZoomViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/17/25.
//

import UIKit
import SnapKit
class ImageZoomViewController: UIViewController {
    
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.showsHorizontalScrollIndicator = false // 나중에 true해보기
        view.showsVerticalScrollIndicator = false
        view.maximumZoomScale = 5.0 // 확대했을때 최대로 얼마까지 늘어나게 할거야?
        view.minimumZoomScale = 1.0 // 숫자 늘리거나 줄여서 확인해보기
        view.bouncesVertically = false // 화면 넘어가서 띠요옹 하는 바운스 효과
        view.delegate = self
        return view
    }()
    
    
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true // 원래 ImageView는 유저인터렉션이 원래 false였고 이미지뷰는 버튼처럼 못쓰겠구나 했었는데 아니였다 !
        return view
    }() // 정의와 실행을 같이 !
    
    // 이미지 확대 축소 기능을 만드려면 어떻게 해야할까!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2 // 두번 눌렀을때 줌인 됐음 좋겠다 !
        imageView.addGestureRecognizer(tap)
    }
    
    
    
    
    @objc
    func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
            
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    // 이미지 뷰가 늘어나거나 줄어들도록 설정한 상황
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
