import SwiftUI
import Moya

struct ContentView: View {
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    var body: some View {
        
        VStack{
            Text("Hello")
            
            if let postData = postViewModel.postData {
                     Text("ID: \(postData.id)")
                     Text("UserID: \(postData.userId)")
                     Text("Title: \(postData.title)")
                     Text("Body: \(postData.body)")
                 }
            Text(String(postViewModel.postData?.id ?? 0))
        }.task {
            postViewModel.requestPost()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
