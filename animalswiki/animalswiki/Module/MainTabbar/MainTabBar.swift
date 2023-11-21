import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let pickers = UINavigationController(rootViewController: ListContentVC())
    let progress = UINavigationController(rootViewController: DetailProfileVC())
    let pengaturan = UINavigationController(rootViewController: HomeViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        setViewControllers()
    }

    func configureUITabBarItems() {
        // Konfigurasi homeVC
         

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: TabBar.icon1, tag: 0)

        // Konfigurasi pickers
        pickers.tabBarItem = UITabBarItem(title: "Umpan Balik", image: TabBar.icon2, tag: 1)
    
        // Konfigurasi progress
        progress.tabBarItem = UITabBarItem(title: "Aktifitas", image: TabBar.icon3, tag: 2)
        
        // Konfigurasi pengaturan
        pengaturan.tabBarItem = UITabBarItem(title: "Pengaturan", image: TabBar.icon4, tag: 3)
       

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
        UITabBar.appearance().barTintColor = UIColor.white
       
        
        // Warna latar belakang tab bar
    }

    func setViewControllers() {
        setViewControllers([homeVC, pickers, progress, pengaturan], animated: true)
    }
}
