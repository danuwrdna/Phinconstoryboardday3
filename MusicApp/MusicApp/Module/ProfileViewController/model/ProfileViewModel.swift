

import Foundation
import UIKit
protocol ProfileViewModelDelegate: AnyObject {
    func didSelectIcon(section: Int, row: Int)
}

struct ProfileSection {
    let title: String
    let iconName: String
}
class ProfileViewModel{
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
           let favoriteMusicVC = MusicViewController()
           favoriteMusicVC.navigationItem.setHidesBackButton(true, animated: true)
           navigationController?.pushViewController(favoriteMusicVC, animated: true)
       }

       private func navigateToLogout(_ navigationController: UINavigationController?) {
           let logoutVC = LoginViewController()
           logoutVC.hidesBottomBarWhenPushed = true
           navigationController?.pushViewController(logoutVC, animated: true)
       }
}
