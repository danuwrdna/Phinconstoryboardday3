import Foundation

// MARK: - Artist
struct ArtistApi: Codable {
    let id: Int?
    let name: String?
    let link, share, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let nbAlbum, nbFan: Int?
    let radio: Bool?
    let tracklist: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case nbAlbum = "nb_album"
        case nbFan = "nb_fan"
        case radio, tracklist, type
    }
}
class ArtistApiModel {
    private let cache = URLCache.shared
    
    func fetchArtist(withID artistID: Int, completion: @escaping (Result<ArtistApi, Error>) -> Void) {
        let apiUrl = "https://api.deezer.com/artist/\(artistID)"
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            do {
                let artist = try JSONDecoder().decode(ArtistApi.self, from: cachedResponse.data)
                completion(.success(artist))
                return
            } catch {
            }
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let artist = try JSONDecoder().decode(ArtistApi.self, from: data)
                let cachedResponse = CachedURLResponse(response: response!, data: data)
                self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                
                completion(.success(artist))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
}
