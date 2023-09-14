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

    func requestImageURL(imageData: Data, completion: @escaping (Result<ImageURLModel, Error>) -> Void) {
        provider.request(.getImageURL(imageData: imageData)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(ImageURLModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getImageURL = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                    completion(.success(decodedResponse))
                } catch let error {
                    print("Decoding error imageurl: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error imageurl: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    func requestTeachableData(completion: @escaping (Result<TeachableModel, Error>) -> Void) {
        provider.request(.getData) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(TeachableModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getData = decodedResponse
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
//    // MARK : Ver.1
//    // url요청 함수
//    func requestImageURL1(imageData: Data) async {
//        provider.request(.getImageURL(imageData: imageData)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decodedResponse = try JSONDecoder().decode(ImageURLModel.self, from: response.data)
//                    DispatchQueue.main.async {
//                        self.getImageURL = decodedResponse
//                    }
//                    print("result : \(decodedResponse)")
//                } catch let error {
//                    print("Decoding error imageurl: \(error.localizedDescription)")
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//
////     분석요청 함수
//    func requestTeachableData1() async {
//        provider.request(.getData) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decodedResponse = try JSONDecoder().decode(TeachableModel.self, from: response.data)
//                    DispatchQueue.main.async {
//                        self.getData = decodedResponse
//                    }
//                    print("result : \(decodedResponse)")
//                } catch let error {
//                    print("Decoding error Teach: \(error.localizedDescription)")
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
}
