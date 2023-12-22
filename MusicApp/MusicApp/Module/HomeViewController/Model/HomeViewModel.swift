import Foundation
import CoreData
import UIKit
class HomeViewModel{
    private var viewController = HomeViewController()
    var data: [Music] = []
    init(viewController: HomeViewController) {
        self.viewController = viewController
        
    }
}
extension HomeViewModel{
    
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
    
}
