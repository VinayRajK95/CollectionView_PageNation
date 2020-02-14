//
//  IndicatorCollectionReusableView.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 14/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class IndicatorCollectionReusableView: UICollectionReusableView {
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        setupIndicator()
    }
    
    func setupIndicator() {
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
    }
}
