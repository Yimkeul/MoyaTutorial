//
//  PhotoPickerView.swift
//  MoyaTutorial
//
//  Created by yimkeul on 2023/09/06.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @StateObject private var photoPickerViewModel = PhotoPickerViewModel()
    @StateObject var imageURLViewModel: TeachableViewModel = TeachableViewModel()
    @StateObject var teachableModel: TeachableViewModel = TeachableViewModel()
    

    func processData(uiImage: UIImage, completion: @escaping (Error?) -> Void)  {
        guard let imageData = uiImage.jpegData(compressionQuality: 1.0) else {
            return print("imageData is nil")
        }
        imageURLViewModel.requestImageURL(imageData: imageData) { imageURLResult in
            switch imageURLResult {
            case .success:
                teachableModel.requestTeachableData { teachableResult in
                    switch teachableResult {
                    case .success:
                        completion(nil) // 모든 작업이 성공적으로 완료되었을 때
                    case .failure(let teachableError):
                        completion(teachableError) // teachableModel 요청 중 에러 발생
                    }
                }
            case .failure(let imageURLError):
                completion(imageURLError) // imageURLViewModel 요청 중 에러 발생
            }
        }
    }

    
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Hello")
            if let image = photoPickerViewModel.selectedImage {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .onAppear {
                         processData(uiImage: image) { error in
                            if let error = error {
                                // 에러 처리
                                print("Error: \(error.localizedDescription)")
                            } else {
                                // 성공적으로 처리된 경우
                                print("Processing completed successfully")

                            }
                        }
                    }
                    
            } else {
              Text("asdfads")
            }
            // 사진 모달 여는 버튼
            PhotosPicker(selection: $photoPickerViewModel.imageSelection) {
                Text("Open the photo picker")
                    .foregroundColor(.red)
            }
        }
    }
    
}



struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}

// processData(uiImage: image) { error in
//                    if let error = error {
//                        // 에러 처리
//                        print("Error: \(error.localizedDescription)")
//                    } else {
//                        // 성공적으로 처리된 경우
//                        print("Processing completed successfully")
//
//                    }
//                }




//struct PhotoPickerView: View {
//    @StateObject private var photoPickerViewModel = PhotoPickerViewModel()
//    @StateObject var imageURLViewModel: TeachableViewModel = TeachableViewModel()
//    @StateObject var teachableModel: TeachableViewModel = TeachableViewModel()
//
//    func processData(image: UIImage, completion: @escaping (Error?) -> Void) {
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
//            return print("imageData is nil")
//        }
//        imageURLViewModel.requestImageURL(imageData: imageData) { imageURLResult in
//            switch imageURLResult {
//            case .success:
//                teachableModel.requestTeachableData { teachableResult in
//                    switch teachableResult {
//                    case .success:
//                        completion(nil) // 모든 작업이 성공적으로 완료되었을 때
//                    case .failure(let teachableError):
//                        completion(teachableError) // teachableModel 요청 중 에러 발생
//                    }
//                }
//            case .failure(let imageURLError):
//                completion(imageURLError) // imageURLViewModel 요청 중 에러 발생
//            }
//        }
//    }
//
//
//    var body: some View {
//        VStack(spacing: 40) {
//            Text("Hello")
//            // 이미지 뜨는 곳
//            if let image = photoPickerViewModel.selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 200, height: 200)
//                Text("\(image)").onReceive(image) { newValue in
//                    processData(image: newValue) { error in
//                        if let error = error {
//                            // 에러 처리
//                            print("Error: \(error.localizedDescription)")
//                        } else {
//                            // 성공적으로 처리된 경우
//                            print("Processing completed successfully")
//                            photoPickerViewModel.imageSelection = nil
//
//                        }
//                    }
//                }
//
//            }
//            // 사진 모달 여는 버튼
//            PhotosPicker(selection: $photoPickerViewModel.imageSelection) {
//                Text("Open the photo picker")
//                    .foregroundColor(.red)
//            }
//        }
//    }
//}
