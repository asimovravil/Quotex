//
//  MainViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    let sections: [SectionType] = [.promos, .main]
    
    private let bannerImages = [
        AppImage.banner1.uiImage,
        AppImage.banner2.uiImage,
        AppImage.banner3.uiImage,
        AppImage.banner4.uiImage
    ]
    
    private let cellImages = [
        AppImage.cell1.uiImage,
        AppImage.cell2.uiImage,
        AppImage.cell3.uiImage,
        AppImage.cell4.uiImage,
        AppImage.cell5.uiImage
    ]
    
    private let quizTitle = [
        "Bulls & Bears",
        "TraderCrunch",
        "Trading Titans",
        "Market Focus",
        "Stock Surge"
    ]
    
    private let quizSubTitle = [
        "10 Questions",
        "10 Questions",
        "15 Questions",
        "12 Questions",
        "15 Questions"
    ]
    
    private let separatorImages = [
        AppImage.bluesep1.uiImage,
        AppImage.bluesep2.uiImage,
        AppImage.bluesep3.uiImage,
        AppImage.bluesep4.uiImage
    ]
    
    // MARK: - UI
    
    private lazy var shadeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.shademain.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var separatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.bluesep1.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseID)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
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
        view.addSubview(shadeView)
        view.addSubview(mainCollectionView)
        mainCollectionView.addSubview(separatorImageView)
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        shadeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        separatorImageView.snp.makeConstraints { make in
            make.top.equalTo(mainCollectionView.snp.top).offset(230)
            make.centerX.equalTo(mainCollectionView.snp.centerX)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Hot News"
        titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        titleLabel.textColor = AppColor.whiteCustom.uiColor
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .promos
            switch section {
            case .promos:
                return self?.promoSectionLayout()
            case .main:
                return self?.mainSectionLayout()
            }
        }
    }
    
    // MARK: - sectionLayout
    
    private func promoSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .absolute(160)
            ),
            subitems: [item]
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 15,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func mainSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(169),
                heightDimension: .absolute(191)
            )
        )
        item.contentInsets.trailing = 20
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(50)
            ),
            subitem: item,
            count: 1
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 32
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 65,
            leading: 16,
            bottom: 10,
            trailing: -16
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .promos:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                fatalError("Could not cast to BannerCollectionViewCell")
            }
            cell.setBannerImage(bannerImages[indexPath.item])
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.reuseID,
                for: indexPath
            ) as? MainCollectionViewCell else {
                fatalError("Could not cast to MainCollectionViewCell")
            }
            cell.setCellImage(cellImages[indexPath.item])
            cell.setQuizTitle(quizTitle[indexPath.item])
            cell.setQuizSubTitle(quizSubTitle[indexPath.item])
            
            if indexPath.item == 0 {
                cell.quizLabel.isHidden = false
                cell.accessImageView.image = AppImage.timegreen.uiImage
            } else {
                cell.accessImageView.image = AppImage.closered.uiImage
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .promos:
            return bannerImages.count
        case .main:
            return 5
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: mainCollectionView.contentOffset, size: mainCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = mainCollectionView.indexPathForItem(at: visiblePoint),
              indexPath.section == 0 /* promo section index */ else {
            return
        }
        
        updateSeparatorImage(for: indexPath)
    }
    
    private func updateSeparatorImage(for indexPath: IndexPath) {
        if indexPath.item < separatorImages.count {
            separatorImageView.image = separatorImages[indexPath.item]
        }
    }
}
