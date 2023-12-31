//
//  BannerCollectionViewCell.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: BannerCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
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
        contentView.addSubview(bannerImageView)
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    func setBannerImage(_ image: UIImage?) {
        bannerImageView.image = image
    }
}
