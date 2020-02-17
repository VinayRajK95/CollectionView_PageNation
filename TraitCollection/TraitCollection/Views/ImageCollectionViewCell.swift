//
//  ImageCollectionViewCell.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 13/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let innerImageView = UIImageView(frame: CGRect.zero)
        innerImageView.contentMode = .scaleAspectFill
        innerImageView.layer.cornerRadius = 10
        innerImageView.layer.masksToBounds = true
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        return innerImageView
    }()
    
    let containerView: UIView = {
        let innerView = UIView(frame: CGRect.zero)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.clear
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOffset = CGSize.zero
        innerView.layer.shadowOpacity = 0.5
        return innerView
    }()
    
    var constraintsForCell = [NSLayoutConstraint]()
    
    fileprivate var subViewDict: [String: AnyObject]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.addSubview(containerView)
        containerView.addSubview(imageView)
        subViewDict = ["containerView":containerView,"imageView":imageView]
        
        constraintsForCell += NSLayoutConstraint.createConstraint(format:"H:|[containerView]|" ,subViewDict: subViewDict);
        constraintsForCell += NSLayoutConstraint.createConstraint(format:"V:|[containerView]|" ,subViewDict: subViewDict);
        
        constraintsForCell += NSLayoutConstraint.createConstraint(format:"H:|[imageView]|" ,subViewDict: subViewDict);
        constraintsForCell += NSLayoutConstraint.createConstraint(format:"V:|[imageView]|" ,subViewDict: subViewDict);
        
        NSLayoutConstraint.activate(constraintsForCell)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}

extension ImageCollectionViewCell: UpdateCells {
    
    internal func configure(imgData: Data) {
        self.imageView.image = UIImage(data: imgData)
    }

}
