//
//  Onboarding1ViewController.swift
//  Quotex
//
//  Created by Ravil on 18.10.2023.
//

import UIKit
import SnapKit

final class Onboarding1ViewController: UIViewController {

    // MARK: - UI
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(AppColor.grayCustom.uiColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "THE APP ABOUT TRADING #1"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 44)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome To The Best Application For Learning\nTrading By Passing Quizzes!"
        label.textAlignment = .center
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var onboardingLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.onboardingLogo1.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.backgroundColor = AppColor.blueCustom.uiColor
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [skipButton, titleLabel, subTitleLabel, onboardingLogoView, nextButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        onboardingLogoView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(100)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let skipBarButton = UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem = skipBarButton
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    @objc private func skipButtonTapped() {
        let controller = TabBarController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        let controller = Onboarding2ViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
