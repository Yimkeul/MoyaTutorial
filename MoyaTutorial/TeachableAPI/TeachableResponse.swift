//
//  TeachableResponse.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import Foundation

struct TeachableModel: Codable {
    let classProbabilities: [[Double]]
    let topClassIndex: Int
    let resultMessage: String
}

struct ImageURLModel: Codable {
    let imageURL: String
}
