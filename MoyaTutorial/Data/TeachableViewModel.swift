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
}

extension TeachableService: TargetType {
    var baseURL: URL {
        return URL(string: "https://port-0-teachablemachineapi-2u73n2llm7ax6bh.sel5.cloudtype.app")!
    }

    var path: String {
        switch self {
        case .getData:
            return "/predict"
        }
        
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

class TeachableViewModel: ObservableObject {
    @Published var getData: TeachalbeModel?

    func requestTeachableData() {
        let provider = MoyaProvider<TeachableService>()
        provider.request(.getData) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(TeachalbeModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getData = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                } catch let error {
                    print("Decoding error Teach: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
