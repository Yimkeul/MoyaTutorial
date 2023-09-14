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
        
        teachableModel.requestAll(imageData: imageData) { teachableResult in
            switch teachableResult {
            case .success:
                completion(nil) // 모든 작업이 성공적으로 완료되었을 때
            case .failure(let teachableError):
                completion(teachableError) // teachableModel 요청 중 에러 발생
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
                        teachableModel.isDone = false // progressview toggle
                        teachableModel.getAll = nil
                         processData(uiImage: image) { error in
                            if let error = error {
                                // 에러 처리
                                print("Error: \(error.localizedDescription)")
                                teachableModel.isDone = true
                            } else {
                                // 성공적으로 처리된 경우
                                print("Processing completed successfully")

                            }
                        }
                    }
            }
            if teachableModel.isDone {
                // 사진 모달 여는 버튼
                VStack{
                    PhotosPicker(selection: $photoPickerViewModel.imageSelection) {
                        Text("Open the photo picker")
                            .foregroundColor(.red)
                    }
                }
            }else {
                ProgressView()
            }
            
            if let result = teachableModel.getAll?.resultMessage {
                Text("result : \(result)")
            }
            
        }
    }
    
}



struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}

