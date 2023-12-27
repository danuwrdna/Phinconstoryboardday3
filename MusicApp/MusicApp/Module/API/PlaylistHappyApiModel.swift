// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlistAPI = try? JSONDecoder().decode(PlaylistAPI.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlistAPI = try? JSONDecoder().decode(PlaylistAPI.self, from: jsonData)

import Foundation

// MARK: - PlaylistAPI
struct PlaylistAPI: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let duration: Int?
    let playlistAPIPublic: Bool?
    let isLovedTrack: Bool?
    let collaborative: Bool?
    let nbTracks: Int?
    let fans: Int?
    let link: String?
    let share: String?
    let picture: String?
    let pictureSmall: String?
    let pictureMedium: String?
    let pictureBig: String?
    let pictureXl: String?
    let checksum: String?
    let tracklist: String?
    let creationDate: String?
    let md5Image: String?
    let pictureType: String?
    let creator: Creator?
    let type: String?
    let tracks: dataTracks?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case duration = "duration"
        case playlistAPIPublic = "public"
        case isLovedTrack = "is_loved_track"
        case collaborative = "collaborative"
        case nbTracks = "nb_tracks"
        case fans = "fans"
        case link = "link"
        case share = "share"
        case picture = "picture"
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case checksum = "checksum"
        case tracklist = "tracklist"
        case creationDate = "creation_date"
        case md5Image = "md5_image"
        case pictureType = "picture_type"
        case creator = "creator"
        case type = "type"
        case tracks = "tracks"
    }
}

// MARK: - Creator
struct Creator: Codable {
    let id: Int?
    let name: String?
    let tracklist: String?
    let type: CreatorType?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tracklist = "tracklist"
        case type = "type"
        case link = "link"
    }
}

enum CreatorType: String, Codable {
    case artist = "artist"
    case user = "user"
}

// MARK: - Tracks
struct dataTracks: Codable {
    let data: [Datumm]?
    let checksum: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case checksum = "checksum"
    }
}

// MARK: - Datum
struct Datumm: Codable {
    let id: Int?
    let readable: Bool?
    let title: String?
    let titleShort: String?
    let titleVersion: TitleVersionn?
    let link: String?
    let duration: Int?  // Assuming "duration" is an integer in your JSON data
    let rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics: Int?
    let explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let timeAdd: Int?
    let artist: Creator?
    let album: Albumm?
    let type: DatumTypee?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case readable = "readable"
        case title = "title"
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link = "link"
        case duration = "duration"
        case rank = "rank"
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview = "preview"
        case md5Image = "md5_image"
        case timeAdd = "time_add"
        case artist = "artist"
        case album = "album"
        case type = "type"
    }
}
// MARK: - Album
struct Albumm: Codable {
    let id: Int?
    let title: String?
    let cover: String?
    let coverSmall: String?
    let coverMedium: String?
    let coverBig: String?
    let coverXl: String?
    let md5Image: String?
    let tracklist: String?
    let type: AlbumTypee?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case cover = "cover"
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist = "tracklist"
        case type = "type"
    }
}

enum AlbumTypee: String, Codable {
    case album = "album"
}

enum TitleVersionn: String, Codable {
    case edit = "(Edit)"
    case empty = ""
    case fromBarbieTheAlbum = "(From Barbie The Album)"
    case pnauRemix = "(PNAU Remix)"
    case radioEdit = "(Radio Edit)"
    case remix = "(Remix)"
}

enum DatumTypee: String, Codable {
    case track = "track"
}



class PlaylistHappyApiModel {
    let deezerAPIURL = URL(string: "https://api.deezer.com/playlist/1479458365")!

    func fetchData(completion: @escaping (Result<PlaylistAPI, Error>) -> Void) {
        // Create a data task to fetch the data
        let task = URLSession.shared.dataTask(with: deezerAPIURL) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check if data is available
            guard let data = data else {
                completion(.failure(YourErrorType.dataNotAvailable))
                return
            }
            
            do {
                // Decode the JSON data into PlaylistAPI object
                let playlist = try JSONDecoder().decode(PlaylistAPI.self, from: data)
                
                // Invoke the completion handler with the result
                completion(.success(playlist))
            } catch {
                // Invoke the completion handler with the decoding error
                print("Error decoding playlist data: \(error)")
                completion(.failure(error))
            }
        }
        
        // Resume the data task
        task.resume()
    }
}

// Define a custom error type for better error handling
enum YourErrorType: Error {
    case dataNotAvailable
    // Add other error cases as needed
}
