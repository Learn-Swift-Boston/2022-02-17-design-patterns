import Foundation
import ComposableArchitecture
import Combine

//final class ViewModel: ObservableObject {
//
//    @Published var filteredPosts: [Post] = []
//
//    @Published private var posts: [Post] = [] {
//        didSet {
//            updateFilterValue()
//        }
//    }
//
//    @Published
//    var filteredUser: Int? {
//        didSet {
//            updateFilterValue()
//        }
//    }
//
//    private let fakePosts: [Post]
//
//    private var cancellables: Set<AnyCancellable> = []
//
//    init(posts: [Post] = []) {
//        self.posts = []
//        self.fakePosts = posts
//    }
//
//    private func updateFilterValue() {
//        if let filteredUser = filteredUser {
//            self.filteredPosts = self.posts.filter{ post in
//                post.userId == filteredUser
//            }
//        }
//        else {
//            self.filteredPosts = self.posts
//        }
//    }
//
//    func load(_ fakeData: [Post] = []) {
//        if fakePosts.isEmpty {
//            URLSession.shared
//                .dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
//                .map(\.0)
//                .decode(type: [Post].self, decoder: JSONDecoder())
//                .receive(on: DispatchQueue.main)
//                .replaceError(with: [])
//                .assign(to: \.posts, on: self)
//                .store(in: &cancellables)
//        }
//        else {
//            self.posts = fakePosts
//        }
//    }
//}
