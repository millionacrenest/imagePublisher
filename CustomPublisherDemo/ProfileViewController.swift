//
//  ProfileViewController.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/17/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    private let viewModel = ProfileViewModel()
    // Note: you must to import Combine to get access to AnyCancellable
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let imageURL = URL(string: "https://picsum.photos/200/300") {
                
                self.viewModel.downloadImage(from: imageURL)
            }
        }
        

        cancellable = viewModel.$image.sink { [weak self] state in
            if let image = state {
                self?.render(image)
            }
        }
    }
    
    private func render(_ state: UIImage) {
        
        let relay = PassthroughSubject<UIImage, Never>()

        let subscription = relay
            .sink { value in
                self.profileImageView.image = value
        }

        relay.send(state)
        
    }
    

}
