import SwiftUI
import Moya

struct ContentView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()

    var body: some View {

        VStack {
            Button {
                postViewModel.requestPost()
            } label: {
                Text("통신하기")
            }

            if let getPostData = postViewModel.getPostData {
                Text("ID: \(getPostData.id)")
                Text("UserID: \(getPostData.userId)")
                Text("Title: \(getPostData.title)")
                Text("Body: \(getPostData.body)")
            } else {
                Text("결과값이 없습니다.")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
