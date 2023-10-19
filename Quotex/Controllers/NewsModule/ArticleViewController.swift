//
//  ArticleViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class ArticleViewController: UIViewController {

    var articles: [Article] = []
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 1000
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        loadArticles()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [tableView].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseID, for: indexPath) as? ArticleTableViewCell else {
            fatalError("Could not cast to ArticleTableViewCell")
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
    }
}
