import Foundation

// MARK: - WelcomeElement
struct CatModel: Codable {
    let id: String
    let url: String
    let width, height: Int
}

typealias Welcome = [CatModel]
