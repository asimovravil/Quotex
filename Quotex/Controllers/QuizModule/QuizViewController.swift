//
//  QuizViewController.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class QuizViewController: UIViewController {
    
    var timer: Timer?
    var remainingTime = 330
    var currentQuestionNumber: Int = 0
    
    // MARK: - UI
    
    public lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.text = "05:30"
        label.textColor = AppColor.whiteCustom.uiColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: QuizTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 700
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }

    func startTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer?.fire()
    }

    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            
            DispatchQueue.main.async { [weak self] in
                self?.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            }
        } else {
            timer?.invalidate()
            DispatchQueue.main.async { [weak self] in
                let loseViewController = LoseViewController()
                self?.navigationController?.pushViewController(loseViewController, animated: true)
            }
        }
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [timerLabel, tableView].forEach() {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Bulls & Bears"
        titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        titleLabel.textColor = AppColor.whiteCustom.uiColor
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let timerLabelBarButton = UIBarButtonItem(customView: timerLabel)
        timerLabelBarButton.customView?.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
        }
        
        navigationItem.rightBarButtonItem = timerLabelBarButton
    }

    func moveToNextQuestion() {
        currentQuestionNumber += 1
        setupNavigationBar()
    }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.reuseID, for: indexPath) as? QuizTableViewCell else {
            fatalError("Could not cast to QuizTableViewCell")
        }
        cell.navigationController = self.navigationController
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

