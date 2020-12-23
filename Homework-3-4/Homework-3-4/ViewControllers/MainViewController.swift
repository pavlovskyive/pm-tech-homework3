//
//  MainViewController.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 20.12.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Variables
    
    var isValidationErrorShown: Bool = false {
        didSet {
            animateTextFieldBorderColor()
        }
    }
    
    // MARK: - Views
    
    lazy var footballImageView: UIImageView = {
        let footballImage = UIImage(named: "Football")
        let imageView = UIImageView(image: footballImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var sloganLabel: UILabel = {
        var label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Beyound Limits"
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Username input
    lazy var textField: UITextField = {
        var textField = PaddingTextField()
        textField.placeholder = "Enter username"
        textField.textAlignment = .center
        textField.textContentType = .username
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.adjustsFontForContentSizeCategory = true
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        textField.layer.borderWidth = 2
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // Shows validation errors under input
    lazy var validationLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemRed
        label.numberOfLines = 5
        label.alpha = 0
        label.font = .preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Bottom button for transition to next controller
    lazy var detailsButton: UIButton = {
        let button = RoundedButton()
        button.setTitle("Give Me Some Details", for: .normal)
        button.isEnabled = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setups
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(footballImageView)
        view.addSubview(sloganLabel)
        view.addSubview(textField)
        view.addSubview(validationLabel)
        view.addSubview(detailsButton)
        
        textField.addTarget(self, action: #selector(handleEditingChanged(_:)), for: .editingChanged)
        
        detailsButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        // Don't mind this
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleFootballSwipe(_:)))
        swipeRecognizer.direction = .down
        
        footballImageView.isUserInteractionEnabled = true
        footballImageView.addGestureRecognizer(swipeRecognizer)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            footballImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.adjusted),
            footballImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            footballImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            footballImageView.heightAnchor.constraint(equalTo: footballImageView.widthAnchor),
            
            sloganLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            sloganLabel.topAnchor.constraint(equalTo: footballImageView.bottomAnchor, constant: 20.adjusted),
            sloganLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 20.adjusted),
            textField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            
            validationLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            validationLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5.adjusted),
            validationLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
            
            detailsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            detailsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.adjusted),
            detailsButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
        ])
    }
    
    // MARK: - Functions
    
    func animateTextFieldBorderColor() {
        var color = textField.isFirstResponder ? UIColor.blue.withAlphaComponent(0.5) : UIColor.init(white: 0.5, alpha: 0.5)
        color = isValidationErrorShown ? UIColor.red : color
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = textField.layer.borderColor
        animation.toValue = color.cgColor
        animation.duration = 0.5
        textField.layer.add(animation, forKey: "borderColor")
        textField.layer.borderColor = color.cgColor
    }
    
    // Make validation label visible and assign validation error text to it
    func showValidationError(_ error: String) {
        isValidationErrorShown = true
        
        validationLabel.text = error
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.validationLabel.alpha = 1
            })
    }
    
    // Make validation label invisible when input is OK
    func hideValidationError() {
        isValidationErrorShown = false
        
        UIView.animate(
            withDuration: 1,
            animations: {
                self.validationLabel.alpha = 0
            },
            completion: { isEnded in
                if isEnded {
                    self.validationLabel.text = ""
                }
            })
    }
    
    // validateTextField checks if input is valid (e.g. consists only of latin symbols, numbers, dot, undercsore or dashes. I just assumed this would be acceptable symbols, there was no word about it, but go without validation seems mad to me. Also I wanted to know how to implement this in UIKit so sorry if I shouldn't have done this
    func validateTextField() {
        guard let text = textField.text, !text.isEmpty else {
            detailsButton.isEnabled = false
            hideValidationError()
            
            return
        }
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9-_.].*", options: .caseInsensitive)
            
            if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil {
                detailsButton.isEnabled = false
                showValidationError("Username can contain only alphabetic symbols, numbers, dots, underscores or dashes.")
                
                return
            }
            
            detailsButton.isEnabled = true
            hideValidationError()
            
        } catch {
            // Even regex is save in swift omg.
            preconditionFailure("Illegal regular expression.")
        }
    }
    
    // MARK: - Actions
    
    // Validate input everytime input changes
    @objc func handleEditingChanged(_ textField: UITextField) {
        validateTextField()
    }
    
    // Just for fun. If there is a ball, it should spin
    @objc func handleFootballSwipe(_ sender: UISwipeGestureRecognizer) {
        let spinAnimation = CABasicAnimation.init(keyPath: "transform.rotation")
        let direction: Float = Bool.random() == true ? 1 : -1
        let numberOfSpins = Float(Int.random(in: 2...5))
        spinAnimation.toValue = NSNumber(value: direction * numberOfSpins * 2 * Float.pi)
        spinAnimation.duration = 1.5
        spinAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        footballImageView.layer.add(spinAnimation, forKey: "spinAnimation")
    }
    
    @objc func handleButton() {
        guard let username = textField.text else { return }
        let detailViewController = DetailViewController()
        detailViewController.username = username
        present(detailViewController, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    
    // Hide keyboard when user touch outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        animateTextFieldBorderColor()
    }
    
    // Change border color when text field is first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextFieldBorderColor()
    }

    // Hide keyboard when user press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        animateTextFieldBorderColor()
        
        return true
    }
}
