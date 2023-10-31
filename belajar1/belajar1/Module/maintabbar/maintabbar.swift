import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    let homeVC = UINavigationController(rootViewController:HomeViewController())
    let pickers = UINavigationController(rootViewController: PickersViewController())
    let progress = UINavigationController(rootViewController: ProgressViewController())
    let pengaturan = UINavigationController(rootViewController: SerigalaViewController())
    let foto = UINavigationController(rootViewController: FotoViewController())
    let lainlain1 = UINavigationController(rootViewController: LoginViewController())
    let lainlain2 = UINavigationController(rootViewController: SerigalaViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        setViewControllers()
    }
    
    func configureUITabBarItems(){
        
        homeVC.tabBarItem = UITabBarItem(title: "home", image: TabBar.icon1, tag: 0)
        pickers.tabBarItem = UITabBarItem(title: "Pickers", image: TabBar.icon2, tag: 1)
        progress.tabBarItem = UITabBarItem(title: "Progress", image: TabBar.icon3, tag: 2)
        pengaturan.tabBarItem = UITabBarItem(title: "Serigala", image: TabBar.icon4, tag: 3)
        foto.tabBarItem = UITabBarItem(title: "foto", image: TabBar.icon4, tag: 4)
        lainlain1.tabBarItem = UITabBarItem(title: "LogOut", image: TabBar.icon4, tag: 5)
        lainlain2.tabBarItem = UITabBarItem(title: "Serigala", image: TabBar.icon4, tag: 6)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBar.appearance().tintColor = UIColor.black
    }
    
     func setViewControllers() {
        setViewControllers([homeVC,pickers,progress,pengaturan,foto,lainlain1,lainlain1], animated: true)
    }
    
}

