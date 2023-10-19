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
    
    // MARK: - Onboarding
    
    case onboardingLogo1
    case onboardingLogo2
}
