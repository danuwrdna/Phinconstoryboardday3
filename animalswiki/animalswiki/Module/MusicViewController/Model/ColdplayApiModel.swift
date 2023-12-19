//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcme: Codable {
//    let data: [Datum]?
//    let total: Int?
//    let next: String?
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let id: Int?
//    let readable: Bool?
//    let title, titleShort: String?
//    let titleVersion: TitleVersion?
//    let link: String?
//    let duration, rank: Int?
//    let explicitLyrics: Bool?
//    let explicitContentLyrics, explicitContentCover: Int?
//    let preview: String?
//    let contributors: [Contributor]?
//    let md5Image: String?
//    let artist: Artist?
//    let album: Album?
//    let type: DatumType?
//
//    enum CodingKeys: String, CodingKey {
//        case id, readable, title
//        case titleShort
//        case titleVersion
//        case link, duration, rank
//        case explicitLyrics
//        case explicitContentLyrics
//        case explicitContentCover
//        case preview, contributors
//        case md5Image
//        case artist, album, type
//    }
//}
//
//// MARK: - Album
//struct Album: Codable {
//    let id: Int?
//    let title: String?
//    let cover: String?
//    let coverSmall, coverMedium, coverBig, coverXl: String?
//    let md5Image: String?
//    let tracklist: String?
//    let type: AlbumType?
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, cover
//        case coverSmall
//        case coverMedium
//        case coverBig
//        case coverXl
//        case md5Image
//        case tracklist, type
//    }
//}
//
//enum AlbumType: String, Codable {
//    case album = "album"
//}
//
//// MARK: - Artist
//struct Artist: Codable {
//    let id: Int?
//    let name: Name?
//    let tracklist: String?
//    let type: ArtistType?
//}
//
//enum Name: String, Codable {
//    case bts = "BTS"
//    case coldplay = "Coldplay"
//    case rihanna = "Rihanna"
//    case selenaGomez = "Selena Gomez"
//    case theChainsmokers = "The Chainsmokers"
//}
//
//enum ArtistType: String, Codable {
//    case artist = "artist"
//}
//
//// MARK: - Contributor
//struct Contributor: Codable {
//    let id: Int?
//    let name: Name?
//    let link, share, picture: String?
//    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
//    let radio: Bool?
//    let tracklist: String?
//    let type: ArtistType?
//    let role: Role?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, link, share, picture
//        case pictureSmall
//        case pictureMedium
//        case pictureBig
//        case pictureXl
//        case radio, tracklist, type, role
//    }
//}
//
//enum Role: String, Codable {
//    case main = "Main"
//}
//
//enum TitleVersion: String, Codable {
//    case acousticVersion = "(Acoustic Version)"
//    case empty = ""
//    case radioEdit = "(Radio Edit)"
//    case seebRemix = "(Seeb Remix)"
//}
//
//enum DatumType: String, Codable {
//    case track = "track"
//}
//
//class ColdplayApiModel{
//    func fetchData(completion: @escaping ([Datum]?) -> Void) {
//        guard let url = URL(string: "https://api.deezer.com/artist/892/top?limit=50") else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(Welcme.self, from: data)
//                completion(result.data)
//            } catch {
//                print(error)
//                completion(nil)
//            }
//        }.resume()
//    }
//    func searchData(searchTerm: String, completion: @escaping ([Datum]?) -> Void) {
//        fetchData { [weak self] data in
//            guard let allData = data else {
//                completion(nil)
//                return
//            }
//            let filteredData = allData.filter { datum in
//                let isArtistMatch = datum.artist?.name?.rawValue.lowercased().contains(searchTerm.lowercased()) == true
//                let isTitleMatch = datum.title?.lowercased().contains(searchTerm.lowercased()) == true
//                return isArtistMatch || isTitleMatch
//            }
//
//            completion(filteredData)
//        }
//    }
//
//}
