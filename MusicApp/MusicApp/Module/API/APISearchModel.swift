// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let search = try? JSONDecoder().decode(Search.self, from: jsonData)

import Foundation

// MARK: - Search
struct Search: Codable {
    let data: [Datum]?
    let total: Int?
    let next: String?
}

// MARK: - Datum
struct Datum: Codable {
    let id: StringOrInt?
    let readable: Bool?
    let title, titleShort: String?
    let titleVersion: TitleVersion?
    let link: String?
    let duration: Duration?
    let rank: Rank?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let artist: Artist?
    let album: Album?
    let type: DatumType?
    
    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, album, type
    }
}

// MARK: - Album
struct Album: Codable {
    let id, title: StringOrInt?
    let cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let tracklist: String?
    let type: AlbumType?
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
}

enum AlbumType: String, Codable {
    case album = "album"
}

// MARK: - Artist
struct Artist: Codable {
    let id, name: StringOrInt?
    let link, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let tracklist: String?
    let type: ArtistType?
    var displayName: String? {
        switch id {
        case .string(let stringValue):
            return stringValue
        case .int(let intValue):
            return String(intValue)
        case .none:
            return nil
        }
    }
    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist, type
        
    }
}


enum ArtistType: String, Codable {
    case artist = "artist"
}
enum StringOrInt: Codable {
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            return
        }
        
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        
        throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}
enum Duration: Codable {
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            return
        }
        
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        
        throw DecodingError.typeMismatch(Duration.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}
enum Rank: Codable {
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            return
        }
        
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        
        throw DecodingError.typeMismatch(Rank.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}

enum TitleVersion: Codable {
    case known(String)
    case unknown(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue.lowercased() {
        case "": self = .known("")
        case "(ost drill remix)": self = .known("(OST Drill Remix)")
        case "radio edit": self = .known("Radio Edit")
        case "remastered": self = .known("Remastered")
        default:
            self = .unknown(rawValue)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .known(let value), .unknown(let value):
            try container.encode(value)
            
        }
        
    }
}



enum DatumType: String, Codable {
    case track = "track"
}
class ApiSearchModel {
    
    func fetchData(for query: String, completion: @escaping (Search?) -> Void) {
        let encodedQuery = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.deezer.com/search?q=\(encodedQuery)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchData = try decoder.decode(Search.self, from: data)
                completion(searchData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
extension StringOrInt {
    var stringValue: String? {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return String(value)
        }
    }
}
