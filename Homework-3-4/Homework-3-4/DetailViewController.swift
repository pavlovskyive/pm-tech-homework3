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
    
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Setups
    
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        view.addSubview(navigationBar)
        
        let dismissNavigationItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        dismissNavigationItem.tintColor = .systemRed
        
        navigationItem.rightBarButtonItem = dismissNavigationItem
        
        navigationBar.setItems([navigationItem], animated: true)
    }
    
    
    // MARK: - Actions
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
