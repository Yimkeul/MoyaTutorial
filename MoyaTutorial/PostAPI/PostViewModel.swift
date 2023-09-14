//
//  PostViewModel.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import Foundation
import Moya

class PostViewModel: ObservableObject {
    @Published var getPostData: GetPostData?
    @Published var sendPostData: SendPostData?

    func requestPost() {
        let provider = MoyaProvider<PostService>()
        provider.request(.getPost) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(GetPostData.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getPostData = decodedResponse
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
    
    
    func requestSendPost() {
        let provider = MoyaProvider<PostService>()
        provider.request(.sendPost) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(SendPostData.self, from: response.data)
                    DispatchQueue.main.async {
                        self.sendPostData = decodedResponse
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
