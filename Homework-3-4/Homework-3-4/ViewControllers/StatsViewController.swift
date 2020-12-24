//
//  StatsViewController.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 22.12.2020.
//

import UIKit

class StatsViewController: UIViewController {
    
    // MARK: - Variables
    
    // I really don't know, is it better to reasign image directly from parent view or like that. I hope I will get a feedback on that
    
    var leftImageName: String = "game-icon" {
        didSet {
            leftImageView.image = UIImage(named: leftImageName)
        }
    }
    
    var rightImageName: String = "game-icon" {
        didSet {
            rightImageView.image = UIImage(named: rightImageName)
        }
    }
    
    // MARK: - Views
    
    lazy var leftImageView: UIImageView = {
        let image = UIImage(named: leftImageName)
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let image = UIImage(named: rightImageName)
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Games".localized
        label.font = .preferredFont(forTextStyle: .headline, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rightStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Games".localized
        label.font = .preferredFont(forTextStyle: .headline, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var leftStatsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.font = .preferredFont(forTextStyle: .headline, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rightStatsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.font = .preferredFont(forTextStyle: .headline, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = RoundedButton()
        button.setTitle("Check Stats".localized, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        return stackView
    }()
    
    lazy var leftContainer = UIView()
    lazy var rightContainer = UIView()
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - Functions
    
    func setupViews() {
        view.backgroundColor = .systemGray6
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        view.addSubview(button)
        view.addSubview(leftImageView)
        view.addSubview(rightImageView)
        view.addSubview(leftStatsLabel)
        view.addSubview(rightStatsLabel)
        view.addSubview(leftStatsNumberLabel)
        view.addSubview(rightStatsNumberLabel)
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.adjusted),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.adjusted),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            // left:
            
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25.adjusted),
            leftImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            leftImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 15),
            leftImageView.widthAnchor.constraint(equalTo: leftImageView.heightAnchor),

            leftStatsLabel.bottomAnchor.constraint(equalTo: leftImageView.centerYAnchor, constant: -5.adjusted),
            leftStatsLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10.adjusted),
            
            leftStatsNumberLabel.topAnchor.constraint(equalTo: leftStatsLabel.bottomAnchor, constant: 5.adjusted),
            leftStatsNumberLabel.leadingAnchor.constraint(equalTo: leftStatsLabel.leadingAnchor),
            leftStatsNumberLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5.adjusted),
            
            // right:
            
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25.adjusted),
            rightImageView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5.adjusted),
            rightImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 15),
            rightImageView.widthAnchor.constraint(equalTo: rightImageView.heightAnchor),
            
            rightStatsLabel.bottomAnchor.constraint(equalTo: rightImageView.centerYAnchor, constant: -5.adjusted),
            rightStatsLabel.leadingAnchor.constraint(equalTo: rightImageView.trailingAnchor, constant: 10.adjusted),
            
            rightStatsNumberLabel.topAnchor.constraint(equalTo: rightStatsLabel.bottomAnchor, constant: 5.adjusted),
            rightStatsNumberLabel.leadingAnchor.constraint(equalTo: rightStatsLabel.leadingAnchor),
            rightStatsNumberLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),
        ])
    }
    
    @objc func handleButton() {
        
        let alertVC = AlertViewController()
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        self.present(alertVC, animated: true, completion: nil)
        
        alertVC.alertTitle.text = "What is Lorem Ipsum".localized
        alertVC.alertText.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.".localized
    }
}
