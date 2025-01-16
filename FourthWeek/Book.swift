//
//  Book.swift
//  FourthWeek
//
//  Created by 권우석 on 1/15/25.
//

import Foundation

struct Book: Decodable {
    let documents: [BookDetail]
    let meta: Meta
}

struct Meta: Decodable {
    let is_end = false
}
struct BookDetail: Decodable {
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
}
