

import Foundation

import Foundation

struct Welcome: Codable {
    let id, name: String?
    let link, share, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let nbAlbum, nbFan: Int?
    let radio: Bool?
    let tracklist: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall
        case pictureMedium
        case pictureBig
        case pictureXl
        case nbAlbum
        case nbFan
        case radio, tracklist, type
    }
}
class AllMusicApiModel {
    
    func fetchData(forArtistId artistId: Int, completion: @escaping (Welcome?) -> Void) {
        // URL for Deezer artist API
        let urlString = "https://api.deezer.com/artist/\(artistId)"
        
        // Create URL object
        if let url = URL(string: urlString) {
            // Create URLSession object
            let session = URLSession.shared
            
            // Create data task
            let task = session.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                // Check if data is available
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    // Decode JSON data
                    let artistData = try JSONDecoder().decode(Welcome.self, from: data)
                    
                    // Call completion handler with the decoded data
                    completion(artistData)
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }
            
            // Resume the task
            task.resume()
        }
    }
}

