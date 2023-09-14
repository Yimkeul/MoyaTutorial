//
//  PostService.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/14.
//

import Foundation
import Moya

enum PostService {
    case getPost
    case sendPost
}

extension PostService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .getPost:
            return "posts/1"
        case .sendPost:
            return "posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPost:
            return .get
        case .sendPost:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPost:
            return .requestPlain
        case .sendPost:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
