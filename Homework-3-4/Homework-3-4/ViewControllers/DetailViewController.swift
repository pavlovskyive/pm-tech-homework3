//
//  DetailViewController.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 21.12.2020.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Variables
    
    var username: String = "Anonymous"
    
    // MARK: - Views
    
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let dismissNavigationItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        dismissNavigationItem.tintColor = .systemRed
        navigationItem.rightBarButtonItem = dismissNavigationItem
        navigationBar.setItems([navigationItem], animated: true)
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImage(named: "Happy Face")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = username
        label.font = .preferredFont(forTextStyle: .title1, weight: .heavy)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Player enthusiast".localized
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .tertiaryLabel
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Lorem ipsum text since Jan 2015".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body, weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 16.adjusted
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
    }
    
    // MARK: - Setups
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(navigationBar)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(profileDescriptionLabel)
        view.addSubview(bottomLabel)
        view.addSubview(stackView)
        
        addStatsViewControllers()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),

            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 40.adjusted),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15.adjusted),
            usernameLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            profileDescriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileDescriptionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2.adjusted),
            profileDescriptionLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.adjusted),
            bottomLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.topAnchor.constraint(equalTo: profileDescriptionLabel.bottomAnchor, constant: 10.adjusted),
            stackView.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -20.adjusted),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func addStatsViewControllers() {
        let topStatsViewController = StatsViewController()
        addChild(topStatsViewController)
        
        let bottomStatsViewController = StatsViewController()
        addChild(bottomStatsViewController)
        
        stackView.addArrangedSubview(topStatsViewController.view)
        stackView.addArrangedSubview(bottomStatsViewController.view)
        
        topStatsViewController.view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        bottomStatsViewController.view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        topStatsViewController.didMove(toParent: self)
        bottomStatsViewController.didMove(toParent: self)
        
        topStatsViewController.leftImageName = "video-icon"
        topStatsViewController.leftStatsLabel.text = "Videos".localized
        topStatsViewController.leftStatsNumberLabel.text = String(124)
        
        topStatsViewController.rightImageName = "heart-icon"
        topStatsViewController.rightStatsLabel.text = "Hearts".localized
        topStatsViewController.rightStatsNumberLabel.text = String(5483)
    
        bottomStatsViewController.leftImageName = "game-icon"
        bottomStatsViewController.leftStatsLabel.text = "Games".localized
        bottomStatsViewController.leftStatsNumberLabel.text = String(543)
        
        bottomStatsViewController.rightImageName = "win-icon"
        bottomStatsViewController.rightStatsLabel.text = "Wins".localized
        bottomStatsViewController.rightStatsNumberLabel.text = String(340)
    }
    
    // MARK: - Actions
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
