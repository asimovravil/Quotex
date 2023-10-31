//
//  SplashViewController.swift
//  Quotex
//
//  Created by Ravil on 18.10.2023.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private var viewModel: StructedSettings!
    
    private lazy var nomadLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.quotexLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var splashLoadingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.splashLoading.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let cachedViewModel = SavedSettingsManager.cachedViewModel {
            let vc = StructedManager.createView(viewModel: cachedViewModel)
            self.present(vc, animated: true)
        } else {
            takeMeToTheChurch()
        }
    }
    
    func takeMeToTheChurch() {
        
        RequestResponseManagerService.shared.openGames(
            success: handleSuccessGetGames,
            failure: showAlertWithOoooopsError
        )
    }
    
    func handleSuccessGetGames(_ viewModel: StructedSettings) {
        self.viewModel = viewModel
        print("------")
        print(viewModel)
        print("------")
        if viewModel.sumChecked {
            let vc = StructedManager.createView(viewModel: viewModel)
            self.present(vc, animated: true)
        } else {
            let mainViewController = TabBarController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false)
        }
    }
    
    
    func showAlertWithOoooopsError(_ error: Error) {
        let mainViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false)
    }

    
    // MARK: - setupViews
    
    private func setupViews() {
        [nomadLogoImage, splashLoadingImage].forEach() {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
        startRotationAnimation()
    }

    private func setupConstraints() {
        nomadLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(-9)
            make.trailing.equalToSuperview().offset(16)
        }
        splashLoadingImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-177)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    private func startRotationAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            self.splashLoadingImage.transform = self.splashLoadingImage.transform.rotated(by: .pi)
        }, completion: nil)
    }
}
