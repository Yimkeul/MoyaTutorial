//
//  TeachableViewModel.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import Foundation
import Moya
import Combine

class TeachableViewModel: ObservableObject {
    @Published var getData: TeachableModel? // 분석 결과
    @Published var getAll: TeachableModel? // 분석 결과
    @Published var getImageURL: ImageURLModel? //이미지 url
    @Published var isDone: Bool = true
    private let provider = MoyaProvider<TeachableService>()
    
    func requestAll(imageData: Data, completion: @escaping (Result<TeachableModel, Error>) -> Void) {
        provider.request(.getAll(imageData: imageData)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(TeachableModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getAll = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                    completion(.success(decodedResponse))
                    self.isDone = true
                } catch let error {
                    print("Decoding error Teach: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error Teach: \(error.localizedDescription)")
                self.isDone = false
                completion(.failure(error))
            }
        }
    }
}
