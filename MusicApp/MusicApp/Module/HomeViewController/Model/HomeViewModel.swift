import Foundation
import CoreData
import UIKit
class HomeViewModel{
    private var viewController = HomeViewController()
    var data: [Music] = []
    var apiArtist = ArtistApiModel()
    var apiData: [ArtistApi] = []
    var apiPlaylist = PlaylistHappyApiModel()
    var dataPlaylist: [DataTracksItem] = []
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}
extension HomeViewModel{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            data = result as! [Music]
            viewController.homeTableView.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
        
    }
}
extension HomeViewModel{
    func fetchDataApiArtist() {
        let allArtistIDs = (1...10).map { $0 }
        let dispatchGroup = DispatchGroup()
        var allArtists: [ArtistApi] = []
        var errorOccurred: Error?
        
        for artistID in allArtistIDs {
            dispatchGroup.enter()
            
            apiArtist.fetchArtist(withID: artistID) { result in
                switch result {
                case .success(let artist):
                    allArtists.append(artist)
                case .failure(let error):
                    errorOccurred = error
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = errorOccurred {
                print("Error fetching artists: \(error.localizedDescription)")
            } else {
                print("Number of artists fetched: \(allArtists.count)")
                self.apiData = allArtists
                self.viewController.homeTableView.reloadData()
            }
        }
    }
}
extension HomeViewModel{
    func fetchDataPlaylistHappyMusic() {
        let playlistAPIModel = PlaylistHappyApiModel()
        
        playlistAPIModel.fetchData { result in
            switch result {
            case .success(let playlist):
                DispatchQueue.main.async {
                    print("Playlist Title: \(playlist.title ?? "N/A")")
                    self.dataPlaylist = playlist.tracks?.data ?? []
                    self.viewController.homeTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching playlist data: \(error.localizedDescription)")
            }
        }
    }
    
    
}
extension HomeViewModel{
    
}
