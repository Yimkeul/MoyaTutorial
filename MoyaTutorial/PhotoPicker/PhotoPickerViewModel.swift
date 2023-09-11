//
//  PhotoPickerViewModel.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import SwiftUI
import PhotosUI

//@MainActor
final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil
    {
        didSet {
            selectedImage = nil // 선택한 이미지 데이터 초기화
            setImage(from: imageSelection)
        }
    }

    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)

                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                selectedImage = uiImage
                print("success : \(data), \(uiImage) , \(String(describing: selectedImage))")
            } catch {
                print(error)
            }
        }
    }
}
