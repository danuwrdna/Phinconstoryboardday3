

import Foundation
import UIKit
import FirebaseStorage
protocol ProfileViewModelDelegate: AnyObject {
    func didSelectIcon(section: Int, row: Int)
}

struct ProfileSection {
    let title: String
    let iconName: String
}
struct Userr {
    let profileImageURL: String
}
class ProfileViewModel{
    var profileImageURL: String? 
    weak var delegate: ProfileViewModelDelegate?
    let sectionTitles = ["Content Title", "Preferences"]
    let sectionData: [[ProfileSection]] = [
            [
                ProfileSection(title: "Favorite Music", iconName: "music.note"),
            ],
            [
                ProfileSection(title: "Logout", iconName: "power")
               
            ]
        ]
}
extension ProfileViewModel{
    func didSelectIcon(section: Int, row: Int, navigationController: UINavigationController?) {
        print("didSelectIcon called for section: \(section), row: \(row)")
           switch section {
           case 0:
               switch row {
               case 0:
                   navigateToFavoriteMusic(navigationController)
               default:
                   break
               }
           case 1:
               switch row {
               case 0 :
                   navigateToLogout(navigationController)
               default:
                   break
               }
           default:
               break
           }
       }

       private func navigateToFavoriteMusic(_ navigationController: UINavigationController?) {
           let favoriteMusicVC = CollectionMusicVC()
           favoriteMusicVC.navigationItem.setHidesBackButton(true, animated: true)
           navigationController?.pushViewController(favoriteMusicVC, animated: true)
       }

       private func navigateToLogout(_ navigationController: UINavigationController?) {
           let logoutVC = LoginViewController()
           logoutVC.hidesBottomBarWhenPushed = true
           navigationController?.pushViewController(logoutVC, animated: true)
       }
}
extension ProfileViewModel {
    func fetchProfileImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL = profileImageURL else {
            print("Profile Image URL is nil")
            return
        }

        // Using FirebaseStorage to download the image
        let storageRef = Storage.storage().reference(forURL: imageURL)
        storageRef.getData(maxSize: 1 * 300 * 300) { data, error in
            if let error = error {
                print("Error loading profile image: \(error.localizedDescription)")
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
    }
}
