import Foundation
import CoreData
import UIKit
class SearchViewModel{
    private var viewController = SearchViewController()
    var data: [Music] = []
    var genre: [DataGenre] = []
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
}
extension SearchViewModel{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            data = result as! [Music]
            viewController.tablePageSrchView.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
        
    }
    func fetchDataForGenre() {
        let genreApiModel = GenreApiModel()
        genreApiModel.fetchData { [weak self] result in
            switch result {
            case .success(let genre):
                self?.genre = genre.data ?? []
                DispatchQueue.main.async {
                    self?.viewController.tablePageSrchView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
