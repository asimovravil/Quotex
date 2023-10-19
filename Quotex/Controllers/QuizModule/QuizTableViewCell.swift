//
//  QuizTableViewCell.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import UIKit
import SnapKit

final class QuizTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: QuizTableViewCell.self)
    var quizBrain = QuizBrain()
    private var answerSelected = false
    var userCorrectAnswers = 0
    weak var navigationController: UINavigationController?
    
    // MARK: - UI
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hahahahaha"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var quizCardView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cardQuiz.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var questionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.tradingChart.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var firstAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("1 answer", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var secondAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("2 answer", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var thirdAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("3 answer", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var fourthAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("4 answer", for: .normal)
        button.setTitleColor(AppColor.whiteCustom.uiColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var quitQuizButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.previousInactive.uiImage, for: .normal)
        button.addTarget(self, action: #selector(quitQuizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "01/10"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextQuizButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.nextInactive.uiImage, for: .normal)
        button.addTarget(self, action: #selector(nextQuizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [questionLabel, quizCardView, questionImage, firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, quitQuizButton, countLabel, nextQuizButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        quizCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(126)
        }
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(quizCardView.snp.top).offset(24)
            make.leading.equalTo(quizCardView.snp.leading).offset(16)
            make.trailing.equalTo(quizCardView.snp.trailing).offset(-16)
            make.bottom.equalTo(quizCardView.snp.bottom).offset(-24)
        }
        questionImage.snp.makeConstraints { make in
            make.top.equalTo(quizCardView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(firstAnswerButton.snp.top).offset(-16)
        }
        firstAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(quizCardView.snp.bottom).offset(180)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.width.equalTo(358)
        }
        secondAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(firstAnswerButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.width.equalTo(358)
        }
        thirdAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(secondAnswerButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.width.equalTo(358)
        }
        fourthAnswerButton.snp.makeConstraints { make in
            make.top.equalTo(thirdAnswerButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.width.equalTo(358)
        }
        quitQuizButton.snp.makeConstraints { make in
            make.top.equalTo(fourthAnswerButton.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(fourthAnswerButton.snp.bottom).offset(66)
            make.centerX.equalToSuperview()
        }
        nextQuizButton.snp.makeConstraints { make in
            make.top.equalTo(fourthAnswerButton.snp.bottom).offset(48)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func quitQuizButtonTapped() {
        if quizBrain.questionNumber > 0 {
            quizBrain.prevQuestion()
            updateUI()
        }
    }
    
    @objc private func nextQuizButtonTapped() {
        quizBrain.nextQuestion()
        
        if quizBrain.questionNumber == 0 {
            showResultViewController()
        } else {
            updateUI()
        }
        updateButtonStates()
    }
    
    @objc public func updateUI() {
        let questionText = quizBrain.getQuestionText()
        let answers = quizBrain.getAnswers()
        
        questionLabel.text = questionText
        firstAnswerButton.setTitle(answers[0], for: .normal)
        secondAnswerButton.setTitle(answers[1], for: .normal)
        thirdAnswerButton.setTitle(answers[2], for: .normal)
        fourthAnswerButton.setTitle(answers[3], for: .normal)
        
        countLabel.text = "\(quizBrain.questionNumber + 1)/\(quizBrain.quiz.count)"
        
        firstAnswerButton.backgroundColor = AppColor.blackCustom.uiColor
        secondAnswerButton.backgroundColor = AppColor.blackCustom.uiColor
        thirdAnswerButton.backgroundColor = AppColor.blackCustom.uiColor
        fourthAnswerButton.backgroundColor = AppColor.blackCustom.uiColor
        
        firstAnswerButton.layer.borderWidth = 0.3
        firstAnswerButton.layer.borderColor = AppColor.grayCustom.uiColor.cgColor
        
        secondAnswerButton.layer.borderWidth = 0.3
        secondAnswerButton.layer.borderColor = AppColor.grayCustom.uiColor.cgColor
        
        thirdAnswerButton.layer.borderWidth = 0.3
        thirdAnswerButton.layer.borderColor = AppColor.grayCustom.uiColor.cgColor
        
        fourthAnswerButton.layer.borderWidth = 0.3
        fourthAnswerButton.layer.borderColor = AppColor.grayCustom.uiColor.cgColor
        
        updateButtonStates()
        answerSelected = false
        nextQuizButton.isEnabled = false
        
        if quizBrain.questionNumber == 9 {
             questionImage.isHidden = false
         } else {
             questionImage.isHidden = true
         }
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        if !answerSelected {
            nextQuizButton.isEnabled = true
            
            let userAnswer = sender.currentTitle!
            let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer)
            
            if userGotItRight {
                sender.backgroundColor = AppColor.blueCustom.uiColor
                userCorrectAnswers += 1
            } else {
                sender.backgroundColor = AppColor.blueCustom.uiColor
            }
            answerSelected = true
        }
    }
    
    private func updateButtonStates() {
        if quizBrain.questionNumber == 0 {
            quitQuizButton.setImage(AppImage.previousInactive.uiImage, for: .normal)
        } else {
            quitQuizButton.setImage(AppImage.previous.uiImage, for: .normal)
        }
        
        if quizBrain.questionNumber == quizBrain.quiz.count - 1 {
            nextQuizButton.setImage(AppImage.submitQuiz.uiImage, for: .normal)
        } else {
            nextQuizButton.setImage(AppImage.next.uiImage, for: .normal)
        }
    }
    
    private func showResultViewController() {
        if userCorrectAnswers == 10 {
            let winViewController = WinViewController()
            winViewController.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(winViewController, animated: true)
        } else {
            let loseViewController = LoseViewController()
            loseViewController.userCorrectAnswers = userCorrectAnswers
            loseViewController.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(loseViewController, animated: true)
        }
    }
}

