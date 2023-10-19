//
//  TabBarController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    // MARK: - setupTabBar
    
    private func setupTabBar() {
        let mainViewController = MainViewController()
        let newsViewController = NewsViewController()
        let settingViewController = SettingsViewController()
                
        tabBar.tintColor = AppColor.grayCustom.uiColor
        tabBar.backgroundColor = AppColor.blackCustom.uiColor
                
        mainViewController.tabBarItem = UITabBarItem(
            title: "Home", image: AppImage.homeTabInactive.uiImage,
            selectedImage: AppImage.homeTabActive.uiImage
        )
        mainViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.whiteCustom.uiColor], for: .normal)
        
        newsViewController.tabBarItem = UITabBarItem(
            title: "News", image: AppImage.newsTabInactive.uiImage,
            selectedImage: AppImage.newsTabActive.uiImage
        )
        newsViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.whiteCustom.uiColor], for: .normal)
                
        settingViewController.tabBarItem = UITabBarItem(
            title: "Settings", image: AppImage.settingsTabInactive.uiImage,
            selectedImage: AppImage.settingsTabActive.uiImage
        )
        settingViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.whiteCustom.uiColor], for: .normal)
        
        viewControllers = [mainViewController, newsViewController, settingViewController]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image?.withRenderingMode(.alwaysTemplate)
        return viewController
    }
}
