import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    var visualEffectView: UIVisualEffectView?
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let image = UINavigationController(rootViewController: ImageViewController())
    let list = UINavigationController(rootViewController: IcLoveViewController())
    let profile = UINavigationController(rootViewController: ProfileViewController())

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

        // Konfigurasi pickers
        image.tabBarItem = UITabBarItem(title: "Image", image: TabBar.icon2, tag: 1)
    
        // Konfigurasi progress
        list.tabBarItem = UITabBarItem(title: "List", image: TabBar.icon3, tag: 2)
        
        // Konfigurasi pengaturan
        profile.tabBarItem = UITabBarItem(title: "Profile", image: TabBar.icon4, tag: 3)
       

        // Konfigurasi warna teks
        let normalTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]

        UITabBarItem.appearance().setTitleTextAttributes(normalTextAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)

        // Konfigurasi warna tab bar
        let red = CGFloat(255) / 255.0
        let green = CGFloat(34) / 255.0
        let blue = CGFloat(203) / 255.0
        let tabBarColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        UITabBar.appearance().backgroundColor = tabBarColor
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = tabBarColor
        
       
        
        // Warna latar belakang tab bar
    }

    func setViewControllers() {
        setViewControllers([homeVC, image, list, profile], animated: true)
    }
}
