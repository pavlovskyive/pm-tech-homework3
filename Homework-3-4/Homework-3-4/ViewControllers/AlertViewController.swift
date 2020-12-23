//
//  AlertViewController.swift
//  Homework-3-4
//
//  Created by Vsevolod Pavlovskyi on 23.12.2020.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dismissButton: RoundedButton!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertText: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
    }

    @IBAction func handleButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
