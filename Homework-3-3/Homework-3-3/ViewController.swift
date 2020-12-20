//
//  ViewController.swift
//  Homework-3-3
//
//  Created by Vsevolod Pavlovskyi on 19.12.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Variables
    
    let colors: [UIColor] = [
        .systemYellow,
        .systemOrange,
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemPurple
    ]
    
    // currentColor stores circleView's backround color. If we will try to get color from circleView's background color when the animation is in progress, we couldn't use it to filter colors array and that is how we can get sure that next color will never be same as current color.
    var currentColor: UIColor = .systemRed
    
    // MARK: - Views
    
    lazy var circleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.layer.cornerRadius = view.frame.height / 2
        view.backgroundColor = colors[2]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupGestures()
    }
    
    // MARK: - Functions

    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(circleView)
        circleView.center = view.center
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        
        // Tap action will fire only when double tap will fail
        tap.require(toFail: doubleTap)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        
        swipeUp.direction = .up
        swipeDown.direction = .down
        swipeLeft.direction = .left
        swipeRight.direction = .right
        
        view.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(doubleTap)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    // MARK: - Actions
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut, animations: {
            self.circleView.center = self.view.center
        })
        
        animator.startAnimation()
    }
    
    @objc func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let isCentered = self.circleView.center == self.view.center
        
        let animator = UIViewPropertyAnimator(duration: isCentered ? 0 : 1.5, curve: .easeInOut, animations: {
            self.circleView.center = self.view.center
        })
        
        animator.addCompletion {_ in
            
            // If placement was changed by another animation, don't start moving in circle animation
            guard self.circleView.center == self.view.center else { return }
            
            UIView.animateKeyframes(withDuration: 3, delay: 0, animations: {
                // Number of points determins detalization of the path
                let points = 1000
                // Slice of circle's central angle divided by number of points
                let slice = 2 * CGFloat.pi / CGFloat(points)
                // Radius of cicle given in assignment
                let radius = CGFloat(80)

                for i in 0...points {
                    // Calculate angle for current point
                    let angle = slice * CGFloat(i)
                    // Calculate x and y coordinates depenging on angle and radius
                    let x = self.view.center.x + radius * CGFloat(sin(angle))
                    // We need for center of circle to be at the center of circleView, so radius is substracted
                    let y = self.view.center.y - radius + radius * CGFloat(cos(angle))

                    // Duration of each keyframe
                    let duration = 1 / Double(points)
                    // Starting time of each keyframe
                    let startTime = duration * Double(i)
                    
                    UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                        // Move circle to calculated coordinates
                        self.circleView.center = CGPoint(x: x, y: y)
                    }
                }
            }, completion: { isFinished in
                // If animation finished without interruption, align circleView's center to the controller's view's center (if not, there will be a small misplacement and cicle path animation could not start without moving to view's center first, what takes 1.5 seconds)
                if isFinished {
                    self.circleView.center = self.view.center
                }
            })
        }
        
        animator.startAnimation()
    }
    
    @objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            let animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut, animations: {
                
                switch gestureRecognizer.direction {
                case .up:
                    self.circleView.center.y -= 30
                case .down:
                    self.circleView.center.y += 30
                case .left:
                    self.circleView.center.x -= 30
                default:
                    self.circleView.center.x += 30
                }
                
                // I could use force unwrap here, but forcing something is not really my style 🙂
                self.currentColor = self.colors.filter({ $0 != self.currentColor }).randomElement() ?? self.colors[2]
                
                self.circleView.backgroundColor = self.currentColor
            })
              
            animator.startAnimation()
        }
    }
}

