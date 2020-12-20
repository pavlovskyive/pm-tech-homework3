//
//  ViewController.swift
//  Homework-3-2
//
//  Created by Vsevolod Pavlovskyi on 19.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    // First animation's view
    @IBOutlet weak var scalingBox: UIView!
    
    // Second animation's views
    @IBOutlet weak var boxChagingColor: UIView!
    @IBOutlet weak var circleChangingColor: UIView!
    
    // Third animation's view
    @IBOutlet weak var sqareToCircle: UIView!
    
    // Fourth animation's views
    @IBOutlet weak var rotatingContainer: UIView!
    @IBOutlet weak var topRotatingCircle: UIView!
    @IBOutlet weak var bottomRotatingCircle: UIView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAnimations()
    }
    
    // MARK: - Functions
    
    // Transform sqares into circles
    func setupViews() {
        circleChangingColor.layer.cornerRadius = circleChangingColor.frame.height / 2
        topRotatingCircle.layer.cornerRadius = topRotatingCircle.frame.height / 2
        bottomRotatingCircle.layer.cornerRadius = bottomRotatingCircle.frame.height / 2
    }
    
    func setupAnimations() {
        animateScaling()
        animateChangingColors()
        animateSquareToCircle()
        animateRotation()
    }
    
    // MARK: - Animations
    
    // First animation
    func animateScaling() {
        
        UIView.animate(
            withDuration: 4.0,
            delay: 0,
            options: [.repeat, .autoreverse],
            animations: {
                let scale = CGAffineTransform(scaleX: 2, y: 2)
                self.scalingBox.transform = scale
           }
        )
    }
    
    // Second animation
    func animateChangingColors() {
        
        // I didn't like that animate() made colors' transitions smooth because in the assignment animations were instant. I didn't find any simpler solution to make this task as it was shown in the assignment.
        
        let boxColors: [UIColor] = [.black, .red, .green, .orange, .white, ]
        let circleColors: [UIColor] = [.white, .blue, .yellow, .systemPink, .black]
        
        var currentColorIndex = 0
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.boxChagingColor.backgroundColor = boxColors[currentColorIndex]
            self.circleChangingColor.backgroundColor = circleColors[currentColorIndex]
            
            currentColorIndex = (currentColorIndex + 1) % boxColors.count
        }
    }
    
    // Third animation
    func animateSquareToCircle() {
        
        UIView.animate(
            withDuration: 4.0,
            delay: 0,
            options: [.repeat, .autoreverse],
            animations: {
                self.sqareToCircle.layer.cornerRadius = self.sqareToCircle.frame.height / 2
           }
        )
    }
    
    // Fourth animation
    func animateRotation() {
        
        // I know I could use .reverse instead of running reverse animation inside completion, and I  know there is a .repeate option to use instead of recursive calling this function, but this animation should have a delay before the start and before the reverse animations in the assignment, so this is what I came up with.
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            options: .curveLinear,
            animations: {
                let rotation = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.rotatingContainer.transform = rotation
            }, completion: { _ in
                UIView.animate(
                    withDuration: 1,
                    delay: 0.5,
                    options: .curveLinear,
                    animations: {
                        let rotation = CGAffineTransform(rotationAngle: -2 * CGFloat.pi)
                        self.rotatingContainer.transform = rotation
                    }, completion: { _ in self.animateRotation()}
                )
            }
        )
        
        // This code hurts my eyes as much as it hurts yours.
    }
}
