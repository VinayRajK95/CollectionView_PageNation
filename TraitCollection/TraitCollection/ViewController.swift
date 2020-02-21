//
//  ViewController.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 13/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        let innerCollectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        innerCollectionView.backgroundColor = UIColor.clear
        return innerCollectionView
    }()
    
    fileprivate let collectionViewContainer: UIView = {
        let innerView = UIView(frame: CGRect.zero)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.clear
        return innerView
    }()
    
    fileprivate let networking = Network()
    
    fileprivate let itemstoFetch = 24;
    
    fileprivate var itemsPerRow = 2;
    
    fileprivate var data = [Images]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    fileprivate var boundsChanged: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        boundsChanged = view.bounds
        // Do any additional setup after loading the view.
        
        setupCollectionView()
        registerCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        collectionView.prefetchDataSource = self

        networking.fetchImageData(items: itemstoFetch, completion: updateData(imgs: ))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.bounds != boundsChanged {
            collectionView.collectionViewLayout.invalidateLayout()
            view.layoutIfNeeded()
        }
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionViewContainer)
        collectionViewContainer.addSubview(collectionView)
        var constraints = [NSLayoutConstraint]()
        let padding = getPaddings()
        
        constraints += [collectionViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),collectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:CGFloat(-padding)),collectionViewContainer.leadingAnchor.constraint(equalTo:view.readableContentGuide.leadingAnchor),collectionViewContainer.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor)];
        
        constraints += [collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.safeAreaLayoutGuide.bottomAnchor),collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor, constant: CGFloat(padding)),collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: CGFloat(-padding))];
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.register(IndicatorCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "IndReUsableView")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath);
        let imgData = data[indexPath.row];
        (cell as? UpdateCells)?.configure(imgData: imgData.imageData)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize();
    }
    
    fileprivate func getCellSize() -> CGSize {
        let pageWidth = Int(collectionView.bounds.width)
        getItemsPerRow()
        var cellWidth = pageWidth - (itemsPerRow-1)*Paddings.minInterItemSpacing
        cellWidth = cellWidth/itemsPerRow
        let cellHeight = cellWidth*4/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    fileprivate func getItemsPerRow() {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            itemsPerRow = 2
        case .regular:
           itemsPerRow = 4
        default:
            break
        }
    }
    
    fileprivate func getPaddings() -> Int {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            return Paddings.compactPadding
        case .regular:
            return Paddings.regularPadding
        default:
            return 12
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass {
            switch traitCollection.horizontalSizeClass {
            case .compact:
                 itemsPerRow = 2
            case .regular:
                itemsPerRow = 4
            default:
                itemsPerRow = 2
                break
            }
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

//Footer
extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "IndReUsableView", for: indexPath)
            (footerView as? IndicatorCollectionReusableView)?.webLoaderView.startAnimation()
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            networking.fetchImageData(items: itemstoFetch/2, completion: updateData(imgs:))
        }
    }
    
    fileprivate func updateData(imgs: [Data]) {
        for img in imgs {
            data.append(Images(imageData: img))
        }
    }
    
}

protocol UpdateCells {
    func configure(imgData: Data)
}

extension NSLayoutConstraint {
    
    public static func createConstraint(format: String, subViewDict: [String: AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: subViewDict)
    }
    
}

//extension ViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        if indexPaths.last?.row == data.count - 1 {
//            networking.fetchImageData(items: 5, completion: updateData(imgs:))
//        }
//    }
//}
