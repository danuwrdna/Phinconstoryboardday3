import UIKit
class HomeViewController:
    UIViewController {
    @IBOutlet weak var buttomSheet: UIImageView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func loveButton(_ sender: Any) {
        navigationLB()
    }
    @IBAction func splashBT(_ sender: Any) {
        navigateSplash()
    }
    let customPopup = SitemViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        delegateTable()
        alertLogout()
        setSB()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    func setSB(){
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    @objc func searchButtonTapped() {
        // Instantiate the search view controller
        let searchViewController = SitemViewController()  // Replace SearchViewController with the actual class name of your search view controller
        
        // Present the search view controller
        searchViewController.modalTransitionStyle = .crossDissolve
        searchViewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(searchViewController, animated: true)
    }
    func  alertLogout(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        buttomSheet.isUserInteractionEnabled = true
        buttomSheet.addGestureRecognizer(tapGesture)
    }
    @objc func handleImageTap() {
        showBottomSheet()
    }
    func showBottomSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.logout()
        }
        alertController.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = self.buttomSheet
        alertController.popoverPresentationController?.sourceRect = self.buttomSheet.bounds
        present(alertController, animated: true, completion: nil)
    }
    
    func logout() {
        let bt = LoginViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    func  navigationLB(){
        let bt = IcLoveViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    func navigateSplash(){
        let bt = SoundAnVC()
        self.navigationController?.pushViewController(bt, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerCellWithNib(FirstPictureVC.self)
        homeTableView.registerCellWithNib(SecondPictureCell.self)
        homeTableView.registerCellWithNib(ThirdPictureCell.self)
        homeTableView.registerCellWithNib(FourPictureCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as FirstPictureVC
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SecondPictureCell
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as ThirdPictureCell
            return third
        case 3:
            let four = tableView.dequeueReusableCell(forIndexPath: indexPath) as FourPictureCell
            return four
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 150
        case 2:
            return 200
        case 3:
            return 300
        default:
            return 100
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            return
        case 1:
            return
        case 2:
            if let cell = tableView.cellForRow(at: indexPath) as? ThirdPictureCell{
                let labelValue = cell.adamLabel.text
                let newViewController = ListContentVC()
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            return
        case 3:
            return
            
        default:
            break
        }
    }
}
