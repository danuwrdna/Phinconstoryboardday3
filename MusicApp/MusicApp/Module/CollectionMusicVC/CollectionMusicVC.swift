import UIKit
import CoreData
import Kingfisher
class CollectionMusicVC: UIViewController {
    private let refreshControl = UIRefreshControl()
    var coreDataArray: [Music] = []
    @IBOutlet weak var tableCmView: UITableView!
    @IBAction func deleteBt(_ sender: Any) {
        deleteAllData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        tableCmView.allowsSelection = true
        refreshCoreaData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
        UIView.animate(withDuration: 5) {
               self.view.alpha = 5.0
           }
    }
}
extension CollectionMusicVC: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableCmView.delegate = self
        tableCmView.dataSource = self
        tableCmView.registerCellWithNib(CmTableViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCmView.dequeueReusableCell(withIdentifier: "CmTableViewCell", for: indexPath) as! CmTableViewCell// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        cell.labelCollection?.text = datum.title
        cell.subLabelCollection?.text = datum.subtitle
        if let imageUrlString = datum.image,
           let imageUrl = URL(string: imageUrlString) {
            cell.imgCollection?.kf.setImage(with: imageUrl)
        } else {
            cell.imgCollection?.image = UIImage(named: "placeholderImage")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CollectionMusicVC{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            coreDataArray = result as! [Music]
            tableCmView.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
extension CollectionMusicVC{
    func deleteSelectedData() {
        guard let selectedIndexPath = tableCmView.indexPathForSelectedRow else {
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let selectedData = coreDataArray[selectedIndexPath.row]
        context.delete(selectedData)
        
        do {
            try context.save()
            coreDataArray.remove(at: selectedIndexPath.row)
            tableCmView.reloadData()
        } catch {
            fatalError("Failed to delete data from Core Data: \(error)")
        }
    }
    func deleteAllData() {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

           for data in coreDataArray {
               context.delete(data)
           }

           do {
               try context.save()
               coreDataArray.removeAll()
               tableCmView.reloadData()
           } catch {
               fatalError("Failed to delete all data from Core Data: \(error)")
           }
       }
}
extension CollectionMusicVC{
    func refreshCoreaData(){
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            tableCmView.refreshControl = refreshControl
    }
    @objc func refreshData() {
        fetchDataFromCoreData()
        tableCmView.reloadData()
        refreshControl.endRefreshing()
    }
}
