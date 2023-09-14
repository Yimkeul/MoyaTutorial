//
//  TeachableService.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/14.
//

import Foundation
import Moya
import Combine

enum TeachableService {
    case getAll(imageData: Data)
}

extension TeachableService: TargetType {
    var baseURL: URL {
        return URL(string: "https://port-0-teachablemachineapi-2u73n2llm7ax6bh.sel5.cloudtype.app")!
//        return URL(string : "http://localhost:3000")!
    }

    var path: String {
        switch self {
        case .getAll:
            return "/uploadImage"
        }

    }

    var method: Moya.Method {
        switch self {
        case .getAll:
            return .post
        }

    }

    var task: Moya.Task {
        switch self {
        case .getAll(let imageData):
            return .uploadMultipart([MultipartFormData(provider: .data(imageData), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")])
        }

    }

    var headers: [String: String]? {
        switch self {
        case .getAll:
            return ["Content-type": "multipart/form-data"]
        }

    }
}
