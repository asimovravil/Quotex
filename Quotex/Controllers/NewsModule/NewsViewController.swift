//
//  NewsViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class NewsViewController: UIViewController {

    var articles: [Article] = []
    var article: Article? 
    
    // MARK: - UI
    
    public lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Latest News"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 216
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
        loadArticles()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [newsTitleLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - loadArticles
    
    func loadArticles() {
        let newsAPI = NewsAPI() 
        newsAPI.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching articles: \(error)")
            }
        }
    }

    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Latest News"
        titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        titleLabel.textColor = AppColor.whiteCustom.uiColor
        titleLabel.sizeToFit()

        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not cast to NewsTableViewCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        if indexPath.row < articles.count {
            let article = articles[indexPath.row]
            cell.configure(with: article)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        let articleVC = ArticleViewController()
        articleVC.article = article
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
