//
//  Interactor.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/18/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import Foundation
import UIKit
import Combine

class Interactor {
    private var cancellables = Set<AnyCancellable>()
    
    private var imageModel = ProfileViewModel()
  
    func viewModel() -> MainViewModel{
        let buttonSubject = PassthroughSubject<Void, Never>()
        let buttonSubscriber = AnySubscriber(buttonSubject)
        
        let imageViewSubject = PassthroughSubject<Void, Never>()
        let imageViewSubscriber = AnySubscriber(imageViewSubject)
        
        let colorPublisher = buttonSubject
          .map { self.randomColor() }
          .map(Optional.init)
          .prepend(.gray)
          .eraseToAnyPublisher()
        
        let imagePublisher = imageViewSubject
                 .map { self.randomImage() }
                 .map(Optional.init)                 .eraseToAnyPublisher()

        return MainViewModel(
           buttonAction: buttonSubscriber,
           buttonColor: colorPublisher
           
        )
    }
    
    private func randomColor() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    private func randomImage() -> UIImage {
       var image = UIImage()
       if let imageURL = URL(string: "https://picsum.photos/200/300") {
           print(imageURL)
           
           self.imageModel.downloadImage(from: imageURL)
        if let image = self.imageModel.image {
            return image
        }
       }
        return image
    }
}
