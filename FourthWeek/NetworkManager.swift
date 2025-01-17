//
//  NetworkManager.swift
//  FourthWeek
//
//  Created by 권우석 on 1/16/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callkakaoBookAPI(query: String, page: Int, completionHandler: @escaping (Book) -> Void) {
        
            let url = "https:dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
            let header: HTTPHeaders = [
                "Authorization": APIKey.kakao
            ]
            AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of: Book.self) { response in
                
                print(response.response?.statusCode)
                
                switch response.result{
                case .success(let value):
                    print("SUCCESS")
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                
            }
        }
    }
    
//    func callkakaoBookTest(query: String, page: Int) -> Book {
//        
//            let url = "https:dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
//            let header: HTTPHeaders = [
//                "Authorization": APIKey.kakao
//            ]
//            AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseDecodable(of: Book.self) { response in
//                
//                print(response.response?.statusCode)
//                
//                switch response.result{
//                case .success(let value):
//                    print("SUCCESS")
//                    completionHandler(value)
//                case .failure(let error):
//                    print(error)
//                
//            }
//        }
//    }
//    
    func randomUser(completionHandler: @escaping (String) -> Void) {
            let url = "https://randomuser.me/api/?results=10"
            
            AF.request(url, method: .get).responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let value):
                    print("SUCCESS", value.results[0].name.last)
                    
                    let result = value.results[0].name.last
                    completionHandler(result)
                    
                case .failure(let error):
                    print("ERROR")
                    print(error)
                }
        }
    }
    
    
}
