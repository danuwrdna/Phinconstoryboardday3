
import UIKit
import Kingfisher

class DetailViewController: UIViewController {
//    var customPopupView: PlayedMusicViewController?
    var model = ColdplayApiModel()
    var modelDatum: [Datum] = []
    @IBAction func btBack(_ sender: Any) {
        navigate()
    }
    @IBOutlet weak var tableDetailView: UITableView!
    @IBOutlet weak var imgDetailView: UIImageView!
   private var image: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        delegateTable()
        setupUI()
        fetchDataFromAPI()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func delegateTable(){
        tableDetailView.delegate = self
        tableDetailView.dataSource = self
        tableDetailView.registerCellWithNib(DetailViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelDatum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableDetailView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as! DetailViewCell// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = modelDatum[indexPath.item]
        cell.labelDetail?.text = datum.artist?.name?.rawValue
        cell.subLabelDetail?.text = datum.title
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgDetail?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgDetail?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
extension DetailViewController{
    func navigate(){
        navigationController?.popViewController(animated: true)
    }
    
}
extension DetailViewController{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.modelDatum = data
                DispatchQueue.main.async {
                    self?.tableDetailView.reloadData()
                }
            }
        }
    }
}
extension DetailViewController {
//    func showCustomPopup() {
//        customPopupView = PlayedMusicViewController()
//        customPopupView?.modalPresentationStyle = .overFullScreen
//        customPopupView?.modalTransitionStyle = .crossDissolve
//        present(customPopupView!, animated: true, completion: nil)
//    }
}
