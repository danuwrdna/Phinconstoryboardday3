import UIKit

class ProfileViewController: UIViewController, ProfileViewModelDelegate {
    func didSelectIcon(section: Int, row: Int) {
//        viewModel.didSelectIcon(section: section, row: row, navigationController: navigationController)
    }
    @IBOutlet weak var profileTable: UITableView!
    @IBAction func navigateToEdit(_ sender: Any) {
        navigateEdit()
    }
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        viewModel.delegate = self
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

           // Mengatur ikon cell dengan nama ikon dari data
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

        // Memanggil metode delegasi ketika ikon di tekan
        viewModel.delegate?.didSelectIcon(section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectIcon(section: indexPath.section, row: indexPath.row, navigationController: navigationController)
    }
}
extension ProfileViewController{
    func navigateEdit(){
        let bt = EditViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
}
