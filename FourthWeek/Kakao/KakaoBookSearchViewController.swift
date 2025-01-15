//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import SnapKit // 애플이 만든거 -> 영어 순 정렬
import Kingfisher





class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    //var list: Book? document만 사용할거다 하면 밑
    var list: [BookDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSearchBar()
        configureTableView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        tableView.keyboardDismissMode = .onDrag //  키보드: 드래그했을때 사라졌음 좋겠어!! 이거하나만 해도 키보드 내려간다
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)
        
    }
    
    func callRequest(query: String) {
        print(#function)
        let url = "https:dapi.kakao.com/v3/search/book?query=\(query)"
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of: Book.self) { response in
            
            //print(response.response?.statusCode)
            
            switch response.result{
            case .success(let value):
                print("success")
                //dump(value.documents)
                self.list = value.documents
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}







extension KakaoBookSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        callRequest(query: searchBar.text!)
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = "\(data.title)"
        cell.subTitleLabel.text = "\(data.price)"
        cell.overviewLabel.text = "\(data.contents)"
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
    
    
}

