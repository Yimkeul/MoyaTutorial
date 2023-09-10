import SwiftUI
import Moya

struct ContentView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @StateObject var teachableModel: TeachableViewModel = TeachableViewModel()
    var body: some View {
        
        VStack{
            Text("Hello")
            
            if let getPostData = postViewModel.getPostData {
                     Text("ID: \(getPostData.id)")
                     Text("UserID: \(getPostData.userId)")
                     Text("Title: \(getPostData.title)")
                     Text("Body: \(getPostData.body)")
                 }
            
            Button {
                postViewModel.requestSendPost()
            } label: {
                Text("전송하기")
            }
            
            if let sendPostData = postViewModel.sendPostData {
                Text("send id : \(sendPostData.id)")
            }
            
            if let teachableData = teachableModel.getData {
                Text("결과값 : \(teachableData.topClassIndex)")
                Text("결과값 : \(teachableData.resultMessage)")
            }else {
                ProgressView()
            }

        }.task {
            postViewModel.requestPost()
//            await teachableModel.requestTeachableData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
