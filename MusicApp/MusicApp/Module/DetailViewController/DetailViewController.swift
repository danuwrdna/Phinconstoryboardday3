
import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    var selectedData: Datum?
    @IBOutlet weak var tableDetailView: UITableView!
    @IBOutlet weak var imgDetailView: UIImageView!
   private var image: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        setupUI()
    }
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func delegateTable(){
        tableDetailView.delegate = self
        tableDetailView.dataSource = self
        tableDetailView.registerCellWithNib(DetailViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as! DetailViewCell

                // Mengisi sel dengan data yang sesuai dengan indexPath atau selectedData
                // Misalnya, jika selectedData tidak nil, Anda dapat mengisi sel seperti ini:
                if let selectedData = selectedData {
                    cell.labelDetail?.text = selectedData.artist?.name?.rawValue
                    cell.subLabelDetail?.text = selectedData.title
                    if let imageUrl = selectedData.album?.cover {
                        let url = URL(string: imageUrl)
                        cell.imgDetail?.kf.setImage(with: url)
                    } else {
                        // Handle case when album cover URL is not available
                        cell.imgDetail?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
                    }
                    // Mengatur gambar atau properti lainnya sesuai dengan kebutuhan
                }

                return cell
    }
    
    
}
extension DetailViewController{
    func setImage(image: String) {
        self.image = image
    }
    
    func setupUI() {
        let url = URL(string: self.image)
        imgDetailView.kf.setImage(with: url)
    }
}
