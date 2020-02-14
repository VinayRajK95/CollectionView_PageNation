//
//  Networking.swift
//  TraitCollection
//
//  Created by Vinay Raj K on 13/02/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import Foundation

class Network {
    fileprivate let api = "https://picsum.photos/200/300"
    
    let session = URLSession.shared

    internal  func fetchImageData(items: Int, completion: @escaping ([Data])  -> ()) {
        var imgData: [Data]?
        let url = URL(string: api)
        guard let url1 = url else { return }
        let dispatchGroup = DispatchGroup()
        for _ in 0..<items {
            dispatchGroup.enter()
            session.dataTask(with: url1) { (data, response, error) in
                guard let data = data else { return }
                if imgData == nil {
                    imgData = []
                }
                imgData?.append(data)
                dispatchGroup.leave()
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            guard let images = imgData else { return }
            print(images)
            completion(images)
        }
    }
}
