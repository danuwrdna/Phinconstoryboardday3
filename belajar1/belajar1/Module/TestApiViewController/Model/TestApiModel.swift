import Foundation


// MARK: - Welcome
struct PokemontModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [ResultPokemon]
}

// MARK: - Result
struct ResultPokemon: Codable {
    let name: String
    let url: String
}


