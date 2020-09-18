//
//  ProfileViewModel.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/17/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public func downloadImage(from url: URL) {
        
        print("download image called")
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
