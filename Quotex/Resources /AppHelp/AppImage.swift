//
//  AppImage.swift
//  Quotex
//
//  Created by Ravil on 18.10.2023.
//

import Foundation
import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - AppImage
    
    case quotexLogo
    case splashLoading
    case banner1
    case banner2
    case banner3
    case banner4
    case shademain
    case cell1
    case cell2
    case cell3
    case cell4
    case cell5
    case vectormain
    case closered
    case timegreen
    case bluesep1
    case bluesep2
    case bluesep3
    case bluesep4
    
    // MARK: - Onboarding
    
    case onboardingLogo1
    case onboardingLogo2
}
