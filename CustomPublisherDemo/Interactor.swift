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
  
    func viewModel() -> MainViewModel{
        let buttonSubject = PassthroughSubject<Void, Never>()
        let buttonSubscriber = AnySubscriber(buttonSubject)
        
        let colorPublisher = buttonSubject
          .map { self.randomColor() }
          .map(Optional.init)
          .prepend(.gray)
          .eraseToAnyPublisher()

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
}
