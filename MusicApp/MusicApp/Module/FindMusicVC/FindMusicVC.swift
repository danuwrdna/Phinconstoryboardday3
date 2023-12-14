
import UIKit

class FindMusicVC: UIViewController {

    @IBOutlet weak var viewPlayer: UIView!
    
    @IBOutlet weak var textFieldFindMusicVc: UITextField!
    @IBOutlet weak var viewFindMusic: UIView!
    @IBOutlet weak var tableFindMusic: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
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
        
        viewPlayer.layer.cornerRadius = 16
        viewPlayer.layer.masksToBounds = false
        viewPlayer.layer.shadowColor = UIColor.black.cgColor
        viewPlayer.layer.shadowOpacity = 0.5
        viewPlayer.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewPlayer.layer.shadowRadius = 4.0
        viewPlayer.layer.shouldRasterize = true
        viewPlayer.layer.rasterizationScale = UIScreen.main.scale
    }
}
