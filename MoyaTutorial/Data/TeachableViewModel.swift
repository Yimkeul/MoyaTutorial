//
//  TeachableViewModel.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import Foundation
import Moya
import Combine

enum TeachableService {
    case getData
    case getImageURL(imageData: Data)
}

extension TeachableService: TargetType {
    var baseURL: URL {
//        switch self {
//        case .getData:
//            return URL(string: "https://port-0-teachablemachineapi-2u73n2llm7ax6bh.sel5.cloudtype.app")!
//        case .getImageURL:
//            return URL(string: "http://localhost:3000")!
//        }
        return URL(string: "https://port-0-teachablemachineapi-2u73n2llm7ax6bh.sel5.cloudtype.app")!
//        return URL(string: "http://localhost:3000")!
    }

    var path: String {
        switch self {
        case .getData:
            return "/predict"
        case .getImageURL:
            return "/uploadImage"
        }

    }

    var method: Moya.Method {
        switch self {
        case .getData:
            return .get
        case .getImageURL:
            return .post
        }

    }

    var task: Moya.Task {
        switch self {
        case .getData:
            return .requestPlain
        case .getImageURL(let imageData):
            return .uploadMultipart([MultipartFormData(provider: .data(imageData), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")])
        }

    }

    var headers: [String: String]? {
        switch self {
        case .getData:
            return ["Content-Type": "application/json"]
        case .getImageURL:
            return ["Content-type": "multipart/form-data"]
        }

    }
}

class TeachableViewModel: ObservableObject {
    @Published var getData: TeachableModel? // 분석 결과
    @Published var getImageURL: ImageURLModel? //이미지 url

    private let provider = MoyaProvider<TeachableService>()
    
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
                print("Error: \(error.localizedDescription)")
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
                } catch let error {
                    print("Decoding error Teach: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    
    // MARK : Ver.1
    // url요청 함수
//    func requestImageURL(imageData: Data) async {
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
    
    // 분석요청 함수
//    func requestTeachableData() async {
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
