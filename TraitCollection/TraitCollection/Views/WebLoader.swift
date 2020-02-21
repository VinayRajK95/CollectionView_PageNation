//
//  WebLoader.swift
//  sample
//
//  Created by Vinay Raj K on 19/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class WebLoader: UIView {
    
    @objc var showLoading: Bool = false {
        didSet{
            if self.showLoading {
                startAnimation()
            }
            else {
                stopAnimation()
            }
        }
    }
    
    fileprivate var viewOne : CircularView!
    
    fileprivate var viewTwo : CircularView!
    
    fileprivate var viewThree : CircularView!
    
    fileprivate var viewFour : CircularView!
    
    fileprivate var viewFive : CircularView!
    
    fileprivate var viewSix : CircularView!
    
    fileprivate var viewSeven : CircularView!
    
    fileprivate var viewEight : CircularView!
    
    fileprivate var subViewsDict : [String:UIView]!
    
    fileprivate var views : [CircularView]!
    
    fileprivate var constraintsForSubviews = [NSLayoutConstraint]()
    
    fileprivate var animations = [CAKeyframeAnimation]()
    
    fileprivate let keyTimes = [[0,0.065,0.13],[0.13,0.195,0.26],[0.26,0.325,0.39],[0.39,0.455,0.52],[0.52,0.585,0.65],[0.65,0.71,0.78],[0.78,0.84,0.91],[0.91,0.97,1]]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    }
    
    fileprivate  func commonInit() {
        let zeroRect = CGRect.zero
        viewOne = CircularView(frame: zeroRect)
        viewTwo = CircularView(frame: zeroRect)
        viewThree = CircularView(frame: zeroRect)
        viewFour = CircularView(frame: zeroRect)
        viewFive = CircularView(frame: zeroRect)
        viewSix = CircularView(frame: zeroRect)
        viewSeven = CircularView(frame: zeroRect)
        viewEight = CircularView(frame: zeroRect);
        subViewsDict = ["viewOne":viewOne,"viewTwo":viewTwo,"viewThree":viewThree,"viewFour":viewFour,"viewFive":viewFive,"viewSix":viewSix,"viewSeven":viewSeven,"viewEight":viewEight]
        views = [viewOne,viewTwo,viewThree,viewFour,viewFive,viewSix,viewSeven,viewEight]
        for i in 0..<views.count {
            let view = views[i]
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            animations.append(createAnimation(interval: keyTimes[i]))
        }
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "H:|[viewOne(==10)]", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "H:[viewTwo(==10)]-2-[viewThree(==10)]-2-[viewFour(==10)]", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "H:[viewFive(==10)]|", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "H:[viewEight(==10)]-2-[viewSeven(==10)]-2-[viewSix(==10)]", subViewDict: subViewsDict)
        
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "V:[viewTwo(==10)]-2-[viewOne(==10)]-2-[viewEight(==10)]", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "V:|[viewThree(==10)]", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "V:[viewFour(==10)]-2-[viewFive(==10)]-2-[viewSix(==10)]", subViewDict: subViewsDict)
        constraintsForSubviews += NSLayoutConstraint.createConstraint(format: "V:[viewSeven(==10)]|", subViewDict: subViewsDict)
        
        
        constraintsForSubviews += [viewOne.trailingAnchor.constraint(equalTo: viewTwo.centerXAnchor),viewTwo.leadingAnchor.constraint(equalTo: viewOne.centerXAnchor),viewTwo.topAnchor.constraint(equalTo: viewThree.centerYAnchor),viewThree.bottomAnchor.constraint(equalTo: viewTwo.centerYAnchor),viewFour.topAnchor.constraint(equalTo: viewThree.centerYAnchor),viewFour.trailingAnchor.constraint(equalTo: viewFive.centerXAnchor),viewFive.leadingAnchor.constraint(equalTo: viewFour.centerXAnchor),viewSix.trailingAnchor.constraint(equalTo: viewFive.centerXAnchor),viewSix.bottomAnchor.constraint(equalTo: viewSeven.centerYAnchor),viewSeven.topAnchor.constraint(equalTo: viewSix.centerYAnchor),viewEight.bottomAnchor.constraint(equalTo: viewSeven.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraintsForSubviews)
    }
    
    fileprivate func createAnimation(interval: [CFTimeInterval]) -> CAKeyframeAnimation {
        let animator = CAKeyframeAnimation(keyPath: "backgroundColor")
        animator.values = [UIColor.lightGray.cgColor,
                           UIColor.gray.cgColor,
                           UIColor.lightGray.cgColor]
        animator.keyTimes = interval as [NSNumber]
        animator.duration = 0.8
        animator.fillMode = .forwards
        animator.repeatCount = .infinity
        return animator
    }
    
    public func startAnimation() {
        for i in 0..<views.count {
            let view = views[i]
            let animation = animations[i]
            view.layer.add(animation, forKey: "animation")
        }
    }
    
    public func stopAnimation() {
        for view in views {
            view.layer.removeAllAnimations()
        }
    }

}


class CircularView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.layoutSubviews()
        self.backgroundColor = UIColor.lightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = self.bounds.width/2;
        if self.layer.cornerRadius != radius {
            self.layer.cornerRadius = radius
        }
    }
    
}
