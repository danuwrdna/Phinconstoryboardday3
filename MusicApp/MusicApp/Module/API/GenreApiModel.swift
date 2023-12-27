// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let genre = try? JSONDecoder().decode(Genre.self, from: jsonData)

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let data: [DataGenre]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - Datum
struct DataGenre: Codable {
    let id: Int?
    let name: String?
    let picture: String?
    let pictureSmall: String?
    let pictureMedium: String?
    let pictureBig: String?
    let pictureXl: String?
    let type: TypeEnum?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture"
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case type = "type"
    }
}

enum TypeEnum: String, Codable {
    case genre = "genre"
}
class GenreApiModel {
    func fetchData(completion: @escaping (Result<Genre, Error>) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/genre") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let genre = try decoder.decode(Genre.self, from: data)
                completion(.success(genre))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
