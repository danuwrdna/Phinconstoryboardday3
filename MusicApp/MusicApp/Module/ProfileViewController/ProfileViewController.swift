import UIKit
import FirebaseStorage

class ProfileViewController: UIViewController, ProfileViewModelDelegate {
    func didSelectIcon(section: Int, row: Int) {
//        viewModel.didSelectIcon(section: section, row: row, navigationController: navigationController)
    }
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBAction func navigateToEdit(_ sender: Any) {
        navigateEdit()
    }
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        viewModel.delegate = self
        borderBottomOnly()
        loadProfileImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func delegateTable() {
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.sectionData[indexPath.section][indexPath.row]
        cell.textLabel?.text = data.title
           cell.imageView?.image = UIImage(systemName: data.iconName)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped(_:)))
           cell.imageView?.addGestureRecognizer(tapGesture)
           cell.imageView?.isUserInteractionEnabled = true
        return cell
    }
    @objc func iconTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView,
              let tappedCell = tappedImageView.superview as? UITableViewCell,
              let indexPath = profileTable.indexPath(for: tappedCell) else {
            return
        }
        viewModel.delegate?.didSelectIcon(section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectIcon(section: indexPath.section , row: indexPath.row , navigationController: navigationController)
        
    }
}
extension ProfileViewController{
    func navigateEdit(){
        let bt = EditViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
}
extension ProfileViewController{
    func borderBottomOnly(){
               imgProfile.layer.cornerRadius = 20
               imgProfile.layer.masksToBounds = true
    }
}
extension ProfileViewController{
    func loadProfileImage() {
            viewModel.fetchProfileImage { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        self.imgProfile.image = UIImage(data: imageData)
                    }
                case .failure(let error):
                    print("Failed to fetch profile image: \(error.localizedDescription)")
                }
            }
        }

}
