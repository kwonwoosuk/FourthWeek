//
//  BookViewController.swift
//  FourthWeek
//
//  Created by 권우석 on 1/13/25.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    
    //let collectionView = UICollectionView() 컬렉션뷰는 이렇게 선언하면 안된다 한번은 레이아웃 대충 가이드 해주면서 선언해야함
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    // 검색키워드 tableView programmingly
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell") // 뒤에 붙는 self 메타타입 / 커스텀클래스 그 자체를 등록하는것
     
        
        
        
        
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout { // 이 함수의 반환값이 UICollectionViewLayout 였으면 좋겠다
        //레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }

}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell{
            return cell
        } else  {
            return UICollectionViewCell()
        }
    }
    
    
}
