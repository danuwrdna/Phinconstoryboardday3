
import UIKit

class FindMusicVC: UIViewController {
    var model = ColdplayApiModel()
    var modelDatum: [Datum] = []
    @IBAction func backBT(_ sender: Any) {
        navigate()
    }
    @IBOutlet weak var textFieldFindMusicVc: UITextField!
    @IBOutlet weak var viewFindMusic: UIView!
    @IBOutlet weak var tableFindMusic: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        textFieldFindMusicVc.delegate = self
        delegateTable()
        setupDesign()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        textFieldFindMusicVc.becomeFirstResponder()
    }
}
extension FindMusicVC: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableFindMusic.delegate = self
        tableFindMusic.dataSource = self
        tableFindMusic.registerCellWithNib(RecentlyPlayedCell.self)
        tableFindMusic.registerCellWithNib(ExploreCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let recentlyPlayed = tableView.dequeueReusableCell(forIndexPath: indexPath) as RecentlyPlayedCell
            return recentlyPlayed
        case 1:
            let explore = tableView.dequeueReusableCell(forIndexPath: indexPath) as ExploreCell
            explore.delegate = self
            return explore
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1:
            return 350
        default:
            return 100
        }
    }
    
    
}
extension FindMusicVC{
    func setupDesign(){
        viewFindMusic.layer.cornerRadius = 16
        viewFindMusic.layer.masksToBounds = false
        viewFindMusic.layer.shadowColor = UIColor.black.cgColor
        viewFindMusic.layer.shadowOpacity = 0.5
        viewFindMusic.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewFindMusic.layer.shadowRadius = 4.0
        viewFindMusic.layer.shouldRasterize = true
        viewFindMusic.layer.rasterizationScale = UIScreen.main.scale
    }
}
extension FindMusicVC: ExploreViewCellDelegate{
    func didSelectItemAt(image: String,head: String,title: String, subTitle: String, trackPreview: String) {
        let vc = PlayedViewController()
        vc.setImage(image: image,head: head, title: title, subTitle: subTitle, trackPreview: trackPreview)
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    }
extension FindMusicVC{
    func navigate(){
        navigationController?.popViewController(animated: true)
    }
}
extension FindMusicVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the updated text after the user types
        guard let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if updatedText.isEmpty {
            displayAllData()
        } else {
            performSearch(with: updatedText)
        }
        
        return true
    }
    func displayAllData() {
        // Set the table data to the complete dataset
        let musicViewModel = ColdplayApiModel()
        // Replace this line with your actual method to get all data
        tableFindMusic.reloadData()
    }
    func performSearch(with searchTerm: String) {
        let musicViewModel = ColdplayApiModel()
        model.searchData(searchTerm: searchTerm) { [weak self] data in
            if let data = data as? [Datum] {
                self?.modelDatum = data
                DispatchQueue.main.async {
                    self?.tableFindMusic.reloadData()
                }
            }
        }
    }
    
}
