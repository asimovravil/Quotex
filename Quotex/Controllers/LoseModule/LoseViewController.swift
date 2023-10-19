//
//  LoseViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class LoseViewController: UIViewController {
    
    var userCorrectAnswers: Int = 0
    
    // MARK: - UI
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.closecircle.uiImage, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundResult.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "YOU LOSE"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 44)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You Have Something To Strive For. Learn More About\nTrading And Come Back Again. The Main Thing Is Not\nTo Give Up!"
        label.textAlignment = .center
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var cardResultView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.loseResult.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 64)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var amountSubLabel: UILabel = {
        let label = UILabel()
        label.text = "/10"
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Medium", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Home", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.backgroundColor = AppColor.blueCustom.uiColor
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
        calculateScore()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [closeButton, backgroundImage, titleLabel, subTitleLabel, cardResultView, amountLabel, amountSubLabel, homeButton].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        cardResultView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(125)
            make.centerX.equalToSuperview()
        }
        amountLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardResultView.snp.leading).offset(65)
            make.centerY.equalToSuperview()
        }
        amountSubLabel.snp.makeConstraints { make in
            make.trailing.equalTo(cardResultView.snp.trailing).offset(-57)
            make.centerY.equalToSuperview()
        }
        homeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let closeBarButton = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = closeBarButton
        closeBarButton.customView?.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    @objc private func closeButtonTapped() {
        let controller = TabBarController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func homeButtonTapped() {
        let controller = TabBarController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func calculateScore() {
        amountLabel.text = "\(userCorrectAnswers)"
    }
    
    func configure() {
        calculateScore()
    }
}
