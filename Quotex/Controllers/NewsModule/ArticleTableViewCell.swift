//
//  ArticleTableViewCell.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class ArticleTableViewCell: UITableViewCell {

    static let reuseID = String(describing: ArticleTableViewCell.self)
    var nextNewsButtonTappedHandler: (() -> Void)?

    // MARK: - UI
    
    private lazy var cardNewsView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.newscell.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private lazy var newsSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Oct 18, 2023 10:44"
        label.textAlignment = .left
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMENT-Pound may come unstuck when UK CPI is less sticky"
        label.textAlignment = .left
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Light", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextNewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next News", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.backgroundColor = AppColor.blueCustom.uiColor
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(nextNewsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [cardNewsView, newsSubLabel, newsLabel, descLabel, nextNewsButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cardNewsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(180)
        }
        newsSubLabel.snp.makeConstraints { make in
            make.top.equalTo(cardNewsView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        newsLabel.snp.makeConstraints { make in
            make.top.equalTo(newsSubLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(newsLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        nextNewsButton.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Actions
    
    func configure(with article: Article) {
        newsLabel.text = article.title
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            cardNewsView.sd_setImage(with: url, completed: nil)
        } else {
            cardNewsView.image = AppImage.newscell.uiImage
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm"
        newsSubLabel.text = formatter.string(from: article.publishedAt)
    }
        
    @objc private func nextNewsButtonTapped() {
        nextNewsButtonTappedHandler?()
    }
}
