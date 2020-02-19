//
//  IndicatorCollectionReusableView.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 14/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class IndicatorCollectionReusableView: UICollectionReusableView {
    var webLoaderView: WebLoader!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        webLoaderView = WebLoader()
        webLoaderView.translatesAutoresizingMaskIntoConstraints = false
        setupIndicator()
    }
    
    func setupIndicator() {
        self.addSubview(webLoaderView)
        NSLayoutConstraint.activate([webLoaderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),webLoaderView.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
    }
}
