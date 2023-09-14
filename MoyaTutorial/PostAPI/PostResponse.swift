//
//  PostResponse.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/05.
//

import Foundation

struct GetPostData: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
struct SendPostData: Codable {
    let id: Int
}

