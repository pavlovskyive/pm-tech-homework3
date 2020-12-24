//
//  ViewController.swift
//  Homework-3-1-2
//
//  Created by Vsevolod Pavlovskyi on 24.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // For iPhone implementation is in storyboard's size classes
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            return
        }
        
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            firstStackView.axis = .vertical
            secondStackView.axis = .vertical
        default:
            firstStackView.axis = .horizontal
            secondStackView.axis = .horizontal
        }
    }

}

