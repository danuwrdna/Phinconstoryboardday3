

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
                ProfileSection(title: "Quality", iconName: "gearshape"),
                ProfileSection(title: "Logout", iconName: "power")
               
            ]
        ]
}
extension ProfileViewModel{
    func didSelectIcon(section: Int, row: Int, navigationController: UINavigationController?) {
           switch section {
           case 0: // Section "Content Title"
               switch row {
               case 0: // Row "Favorite Music"
                   navigateToFavoriteMusic(navigationController)
               default:
                   break
               }
           case 1: // Section "Preferences"
               switch row {
               case 1: // Row "Logout"
                   navigateQuality(navigationController)
               default:
                   break
               }
           case 2: // Section "Preferences"
               switch row {
               case 2: // Row "Logout"
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
    private func navigateQuality(_ navigationController: UINavigationController?) {
        let logoutVC = MainTabBarViewController()
        logoutVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(logoutVC, animated: true)
    }
}
