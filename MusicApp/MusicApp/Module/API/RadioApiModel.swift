// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let radio = try? JSONDecoder().decode(Radio.self, from: jsonData)

import Foundation

// MARK: - Radio
struct Radio: Codable {
    let data: [DataRadio]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - Datum
struct DataRadio: Codable {
    let id: Int?
    let title: String?
    let radios: [RadioElement]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case radios = "radios"
    }
}

// MARK: - RadioElement
struct RadioElement: Codable {
    let id: String?
    let title: String?
    let picture: String?
    let pictureSmall: String?
    let pictureMedium: String?
    let pictureBig: String?
    let pictureXl: String?
    let tracklist: String?
    let md5Image: String?
    let type: EnumType?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case picture = "picture"
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist = "tracklist"
        case md5Image = "md5_image"
        case type = "type"
    }
}

enum EnumType: String, Codable {
    case radio = "radio"
}
class RadioApiModel{
    func fetchData(completion: @escaping (Result<Radio, Error>) -> Void) {
            guard let url = URL(string: "https://api.deezer.com/radio/genres") else {
                // Handle invalid URL
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    // Handle empty data
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let radioData = try decoder.decode(Radio.self, from: data)
                    completion(.success(radioData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
