import Foundation

struct Post: Codable, Identifiable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
