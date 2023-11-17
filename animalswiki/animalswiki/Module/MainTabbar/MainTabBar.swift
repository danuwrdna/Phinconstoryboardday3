import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let pickers = UINavigationController(rootViewController: HomeViewController())
    let progress = UINavigationController(rootViewController: HomeViewController())
    let pengaturan = UINavigationController(rootViewController: HomeViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBarItems()
        setViewControllers()
    }

    func configureUITabBarItems() {
        // Konfigurasi homeVC
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: TabBar.icon1, tag: 0)
        homeVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5) // Mengatur posisi teks

        // Konfigurasi pickers
        pickers.tabBarItem = UITabBarItem(title: "Umpan Balik", image: TabBar.icon2, tag: 1)
        pickers.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)

        // Konfigurasi progress
        progress.tabBarItem = UITabBarItem(title: "Aktifitas", image: TabBar.icon3, tag: 2)
        progress.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)

        // Konfigurasi pengaturan
        pengaturan.tabBarItem = UITabBarItem(title: "Pengaturan", image: TabBar.icon4, tag: 3)
        pengaturan.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)

        // Konfigurasi warna teks
        let normalTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue]

        UITabBarItem.appearance().setTitleTextAttributes(normalTextAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)

        // Konfigurasi warna tab bar
        UITabBar.appearance().tintColor = UIColor.blue
        UITabBar.appearance().barTintColor = UIColor.clear
        
        // Warna latar belakang tab bar
    }

    func setViewControllers() {
        setViewControllers([homeVC, pickers, progress, pengaturan], animated: true)
    }
}
