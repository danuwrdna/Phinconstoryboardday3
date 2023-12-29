
import UIKit
import Kingfisher

class DetailViewController: UIViewController {
//    var customPopupView: PlayedMusicViewController?
    private var imageTitle = ""
   
    var modelDatum: [Music] = []
    @IBAction func btBack(_ sender: Any) {
        navigate()
    }
    @IBOutlet weak var tableDetailView: UITableView!
    @IBOutlet weak var imgDetailView: UIImageView!
   private var image: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        borderImgDetailView()
        delegateTable()
        setupUI()
        
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
        cell.labelDetail?.text = datum.title
        cell.subLabelDetail?.text = datum.subtitle
        if let imageUrl = datum.image {
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
    func setImage(image: String, title: String) {
        self.title = title
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
    
}
extension DetailViewController {
    func borderImgDetailView(){
        imgDetailView.layer.cornerRadius = imgDetailView.frame.height / 9
        imgDetailView.clipsToBounds = true
        imgDetailView.layer.masksToBounds = true
        imgDetailView.layer.shadowColor = UIColor.black.cgColor
        imgDetailView.layer.shadowOpacity = 0.5
        imgDetailView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgDetailView.layer.shadowRadius = 4.0
      
        
    }
}
