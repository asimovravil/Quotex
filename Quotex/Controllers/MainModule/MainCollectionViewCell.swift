//
//  MainCollectionViewCell.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: MainCollectionViewCell.self)
    
    // MARK: - UI
    
    public lazy var quizLabel: UILabel = {
        let label = UILabel()
        label.text = "Quizzes"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var quizTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var quizSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.grayCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Light", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.vectormain.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var accessImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [quizLabel, cellImageView, quizTitleLabel, quizSubTitleLabel, vectorImageView, accessImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        quizLabel.snp.makeConstraints { make in
            make.bottom.equalTo(cellImageView.snp.top).offset(-24)
        }
        cellImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        quizTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.top)
            make.leading.equalTo(cellImageView.snp.trailing).offset(20)
        }
        quizSubTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImageView.snp.trailing).offset(20)
            make.bottom.equalTo(cellImageView.snp.bottom)
        }
        vectorImageView.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        accessImageView.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.top).offset(7)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Actions
    
    func setCellImage(_ image: UIImage?) {
        cellImageView.image = image
    }
    
    func setQuizTitle(_ title: String?) {
        quizTitleLabel.text = title
    }
    
    func setQuizSubTitle(_ title: String?) {
        quizSubTitleLabel.text = title
    }
}
