//
//  PostViewModel.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import Foundation
import Moya
import Combine

enum PostService {
    case getPost
}

extension PostService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .getPost:
            return "posts/1"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getPost:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}

class PostViewModel: ObservableObject {
    @Published var postData: PostResponse? // Use PostResponse instead of PostData

    func requestPost() {
        let provider = MoyaProvider<PostService>()
        provider.request(.getPost) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self.postData = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                } catch let error {
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
