//
//  NewsTableViewCell.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class NewsTableViewCell: UITableViewCell {

    static let reuseID = String(describing: NewsTableViewCell.self)

    // MARK: - UI
    
    private lazy var cardNewsView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.newscell.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMENT-Pound may come unstuck when UK CPI is less sticky"
        label.textAlignment = .left
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var newsSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Oct 18, 2023 10:44"
        label.textAlignment = .center
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.numberOfLines = 3
        return label
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
        [cardNewsView, newsLabel, newsSubLabel].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cardNewsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        newsLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardNewsView.snp.leading).offset(16)
            make.trailing.equalTo(cardNewsView.snp.trailing).offset(-16)
            make.bottom.equalTo(newsSubLabel.snp.top).offset(-2)
        }
        newsSubLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardNewsView.snp.leading).offset(16)
            make.bottom.equalTo(cardNewsView.snp.bottom).offset(-16)
        }
    }
    
    // MARK: - Actions
    
    func configure(with article: Article) {
        newsLabel.text = article.title
        if let url = article.urlToImage {
            cardNewsView.sd_setImage(with: url, completed: nil)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm"
        newsSubLabel.text = formatter.string(from: article.publishedAt)
    }
}
