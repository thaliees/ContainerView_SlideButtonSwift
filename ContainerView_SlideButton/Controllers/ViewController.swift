//
//  ViewController.swift
//  ContainerView_SlideButton
//
//  Created by Thaliees on 6/17/19.
//  Copyright © 2019 Thaliees. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var toSlider: UIView!
    @IBOutlet weak var containerView: UIView!
    
    // Created child view to show
    lazy var childrenOneViewController: ChildrenOneViewController = {
        // Specify where the view is definid
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Specify the Stoyboard ID for our view (defined in our storyboard)
        var viewController = storyboard.instantiateViewController(withIdentifier: "OneStoryboard") as! ChildrenOneViewController
        self.addViewControllerAsChild(childViewController: viewController)
        return viewController
    }()
    
    lazy var childrenTwoViewController: ChildrenTwoViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TwoStoryboard") as! ChildrenTwoViewController
        self.addViewControllerAsChild(childViewController: viewController)
        return viewController
    }()
    
    private let trailingView:CGFloat = 40, leadingView:CGFloat = 40 // Trailing and Leading of Autolayout (areaView)
    private let widthScreen = UIScreen.main.bounds.width            // Width of the screen of device
    private var initX:CGFloat = 0.0, limitX:CGFloat = 0.0, widthInitToSlider:CGFloat = 0.0, percentage:CGFloat = 0.0
    private var isButtonOnTheRight:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        widthInitToSlider = toSlider.frame.width                    // Width of ouw UILabel
        // Shaped round (Function created in UIViewExtension)
        areaView.round()
        toSlider.round()
        containerView.roundTop()
        showChildView(showOneView: true)
    }

    @IBAction func handleOnTouch(_ sender: UIPanGestureRecognizer) {
        let traslation = sender.translation(in: toSlider)
        
        if let toSlide = sender.view {
            if limitX == 0 {
                initX = toSlide.center.x
                limitX = widthScreen - (trailingView + leadingView + (widthInitToSlider / 2))
                percentage = (limitX * 0.5)        // Calculate 50%
            }
            
            if sender.state == .changed {
                // Move the button
                if toSlide.center.x > (initX - traslation.x) {
                    toSlide.center.x = toSlide.center.x + traslation.x
                }
                // Move to the end and avoid overflowing the limit
                if toSlide.center.x >= limitX {
                    toSlide.center.x = limitX
                }
                // Move to the start and avoid overflowing the limit
                if toSlide.center.x < initX - traslation.x {
                    toSlide.center.x = initX
                }
            }
            else if sender.state == .ended {
                // What animation to do?
                if isButtonOnTheRight{
                    if toSlide.center.x < limitX - widthInitToSlider / 2{
                        self.moveButtonLeft()
                        showChildView(showOneView: true)
                    }
                    else{
                        self.moveButtonRight()
                    }
                }
                else {
                    // If the position of the movement exceeds 50% of the width of the limitX, expand
                    if toSlide.center.x > limitX - percentage {
                        self.moveButtonRight()
                        showChildView(showOneView: false)
                    }
                    else{
                        self.moveButtonLeft()
                    }
                }
            }
        }
        
        sender.setTranslation(CGPoint.zero, in: toSlider)
    }
    
    // MARK: ChildViews
    private func addViewControllerAsChild(childViewController: UIViewController){
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    private func showChildView(showOneView:Bool){
        childrenOneViewController.view.isHidden = !showOneView
        childrenTwoViewController.view.isHidden = showOneView
    }
    
    // MARK: SlideButton Methods
    private func moveButtonLeft(){
        // Animation
        UIView.animate(withDuration: 0.5) {
            self.isButtonOnTheRight = false
            // Update the position of our UIView
            self.toSlider.center.x = self.initX
        }
    }
    
    private func moveButtonRight(){
        // Animation
        UIView.animate(withDuration: 0.5) {
            self.isButtonOnTheRight = true
            // Update the position of our UIView
            self.toSlider.center.x = self.limitX
        }
    }
}
