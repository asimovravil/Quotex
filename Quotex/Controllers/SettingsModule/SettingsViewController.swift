//
//  SettingsViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private var isVibratorActive = false
    
    // MARK: - UI
    
    public lazy var settingsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .left
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var notificationView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.notification.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var switchNotification: UISwitch = {
        let switchBar = UISwitch()
        switchBar.addTarget(self, action: #selector(notificationButtonTapped), for: .valueChanged)
        return switchBar
    }()
    
    private lazy var rateUsButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.rateUs.uiImage, for: .normal)
        button.addTarget(self, action: #selector(rateUsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareAppButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.shareApp.uiImage, for: .normal)
        button.addTarget(self, action: #selector(shareAppButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.privacyPolicy.uiImage, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [settingsTitleLabel, notificationView, switchNotification, shareAppButton, rateUsButton, privacyPolicyButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        settingsTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(notificationView.snp.top).offset(-24)
        }
        notificationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.centerX.equalToSuperview()
        }
        switchNotification.snp.makeConstraints { make in
            make.trailing.equalTo(notificationView.snp.trailing).offset(-16)
            make.centerY.equalTo(notificationView.snp.centerY)
        }
        shareAppButton.snp.makeConstraints { make in
            make.top.equalTo(notificationView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(shareAppButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(69)
        }
    }
    
    // MARK: - notificationButtonTapped
    
    @objc private func notificationButtonTapped() {
        if switchNotification.isOn {
            print("Notification On")
        } else {
            print("Notification Off")
        }
    }
    
    // MARK: - shareAppButtonTapped
    
    @objc private func shareAppButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: "Share App", preferredStyle: .actionSheet)
        let messageAction = UIAlertAction(title: "Share via Message", style: .default) { [weak self] _ in
            self?.shareAppViaMessage()
        }

        let otherAppsAction = UIAlertAction(title: "Share via Other Apps", style: .default) { [weak self] _ in
            self?.shareAppViaOtherApps()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(messageAction)
        actionSheet.addAction(otherAppsAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
    private func shareAppViaMessage() {
    }

    private func shareAppViaOtherApps() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!

        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - rateUsButtonTapped
    
    @objc private func rateUsButtonTapped() {
        let appName = "Moony Journey"

        if let url = URL(string: "https://itunes.apple.com/search?term=\(appName)&entity=software") {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let results = json["results"] as? [[String: Any]],
                           let firstResult = results.first,
                           let appID = firstResult["trackId"] as? Int {
                            self.openAppStorePage(for: appID)
                        }
                    } catch {
                        print("JSON parsing error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }

    private func openAppStorePage(for appID: Int) {
        let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review")!

        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        } else {
            print("Unable to open App Store URL")
        }
    }
}
