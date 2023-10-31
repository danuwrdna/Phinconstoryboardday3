import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    let homeVC = UINavigationController(rootViewController:HomeViewController())
    let transactionVC = UINavigationController(rootViewController: HomeViewController())
    let notificationVC = UINavigationController(rootViewController: HomeViewController())
    let profileVC = UINavigationController(rootViewController: HomeViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        setViewControllers()
        
    }
    
    func configureUITabBarItems(){
        
        homeVC.tabBarItem = UITabBarItem(title: "home", image: TabBar.icon1, tag: 0)
        transactionVC.tabBarItem = UITabBarItem(title: "notification", image: TabBar.icon2, tag: 1)
        notificationVC.tabBarItem = UITabBarItem(title: "transaction", image: TabBar.icon3, tag: 2)
        profileVC.tabBarItem = UITabBarItem(title: "profile", image: TabBar.icon4, tag: 3)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBar.appearance().tintColor = UIColor.black
    }
    
     func setViewControllers() {
        setViewControllers([homeVC,transactionVC,notificationVC,profileVC], animated: true)
    }
    
}

