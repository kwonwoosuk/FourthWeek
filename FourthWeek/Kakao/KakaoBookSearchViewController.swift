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

/*
 페이지네이션
 1. 스크롤이 끝날쯤 다음 페이지를 요청 (page+=1 후 callRequest)
 2. 이전 내용도 학인해야해서 list.append로 수정 , 수정전에는 갈아끼워주고 있었음
 - 이거 고쳐야하지 않을까?
 - 다른검색어를 입력한 경우, 배열 초기화 page도 다시 1부터 보여줘야한다
 - 검색을 다시 한경우 스크롤을 상단을 다시 올려줘야죵
 - 서버마다 다른긴 하나 빈내용도 최대한 호출을 안해야하니까
 - - 마지막 페이지인경우 더이상 호출하기 않기./ is_end같은게 bool로 없으면 직접 관리해야함
- 서치바의 텍스트가 바뀐채로 스크롤을 하면 엔터키를 누르면 바뀌어야할 검색 결과가 선언해둔 searchBar의 텍스트를 불러오기때문에 스크롤 내용이 업데이트 된다 !
 
 */



class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    //var list: Book? document만 사용할거다 하면 밑
    var list: [BookDetail] = []
    
    var page = 1
    var isEnd = false
    
    
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
        tableView.prefetchDataSource = self
        
    
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)
        
    }
    
    func callRequest(query: String) {
        print(#function)
        let url = "https:dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
        print(#function, url)
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of: Book.self) { response in
            
            //print(response.response?.statusCode)
            
            switch response.result{
            case .success(let value):
                
                if self.page == 1 {
                    self.list = value.documents
                } else {
                    self.list.append(contentsOf: value.documents)
                }
                print("success")
                //dump(value.documents)
                //page 1 번 1-20 리스트 어펜드
                //page 2 번 21-40
                self.isEnd = value.meta.is_end //  끝났는지 true로 바뀔때 ! -> 이걸활용해서 조건설정은 preFetchRowsAt에서 설정
                
                self.list.append(contentsOf: value.documents)
                self.tableView.reloadData()
                if self.page == 1 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension KakaoBookSearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        // size 20개로 설정해둬서
        // 1번부터 20번까지의 배열의 데이터가 들어있는건 사용자가 조회할 수있는 마지막 indexPaths는 [0,19] 이때 호출
        for item in indexPaths {
            if list.count - 2 == item.row && isEnd == false { // 마지막 인덱스패스는 배열보다 하나씩 작을수 밖에 없당 // 마지막 페이지가 아닌경우에만 리로드
                page += 1
                callRequest(query: searchBar.text!) // 계속 21번부터 40번까지만 불러오는겨 ==> , page: 2
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
}



extension KakaoBookSearchViewController: UISearchBarDelegate {
    // 검색버튼 클릭시 무조건 통신되지 않고, 빈칸,  최소 1자 이상 , 같은 글자를 다시 엔터 누를경우 같은 경우 처리 필요!
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1 //  요청하기 전에 1로 바꿔놓고 설정 //  엔터키를 칠곳은 여기 일것같당
        callRequest(query: searchBar.text!)
        
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        //print(#function)
        let data = list[indexPath.row]
        
        cell.titleLabel.text = "\(data.title)"
        cell.subTitleLabel.text = "\(data.price)"
        cell.overviewLabel.text = "\(data.contents)"
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        print(#function, indexPath)
    //    }
    //
    //UIScrollViewDelegate -> 상속 구조상 테이블뷰가 스크롤뷰를 상속받고있어서 따로 delegate를 채택하지 않아도 이미 갖고 있다
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        print(#function , scrollView.contentSize.height, scrollView.contentOffset.y)
    //    }
    //
    //
    //}
}
