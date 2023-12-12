import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    var visualEffectView: UIVisualEffectView?
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let search = UINavigationController(rootViewController: SearchViewController())
    let profile = UINavigationController(rootViewController: ProfileViewController())
    let collection = UINavigationController(rootViewController: CollectionMusicVC())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        setViewControllers()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    func configureUITabBarItems() {
        // Konfigurasi homeVC
         

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: TabBar.icon1, tag: 0)
        search.tabBarItem = UITabBarItem(title: "Search", image: TabBar.icon2, tag: 1)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: TabBar.icon3, tag: 2)
        collection.tabBarItem = UITabBarItem(title: "Collection", image: TabBar.icon4, tag: 3)
       
       

        // Konfigurasi warna teks
        let normalTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]

        UITabBarItem.appearance().setTitleTextAttributes(normalTextAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)

        // Konfigurasi warna tab bar
        let red = CGFloat(73) / 255.0
        let green = CGFloat(94) / 255.0
        let blue = CGFloat(87) / 255.0
        let tabBarColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        UITabBar.appearance().backgroundColor = tabBarColor
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = tabBarColor
        
       
        
        // Warna latar belakang tab bar
    }

    func setViewControllers() {
        setViewControllers([homeVC, search, profile,collection], animated: true)
    }
}
