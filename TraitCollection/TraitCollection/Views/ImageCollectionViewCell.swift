//
//  ImageCollectionViewCell.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 13/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    let imageView : UIImageView = {
        let innerImageView = UIImageView(frame: CGRect.zero)
        innerImageView.contentMode = .scaleAspectFit
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        return innerImageView
    }()
    
    var constraintsForCell = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.addSubview(imageView)
        constraintsForCell = [imageView.topAnchor.constraint(equalTo: self.topAnchor),imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)];
        NSLayoutConstraint.activate(constraintsForCell)
    }
    
}

extension ImageCollectionViewCell: UpdateCells {
    
    internal func configure(imgData: Data) {
        self.imageView.image = UIImage(data: imgData)
    }

}
