//
//  CombineHelpers.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/18/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import Combine
import Foundation
import UIKit

class UIControlPublisher<Control: UIControl>: Publisher {
    typealias Output = UIControl
    typealias Failure = Never
    
    private let control: UIControl
    private let event: UIControl.Event
    private let subject = PassthroughSubject<Output, Failure>()
    
    deinit {
        control.removeTarget(self, action: nil, for: event)
    }
   
    init(control: UIControl, event: UIControl.Event) {
        self.control = control
        self.event = event
        
        control.addTarget(
            self,
            action: #selector(handler(sender:)),
            for: event
        )
    }

    func receive<S>(subscriber: S) where S : Subscriber,
       S.Failure == UIControlPublisher.Failure,
       S.Input == UIControlPublisher.Output {
            subject.subscribe(subscriber)
    }

    @objc private func handler(sender: UIControl) {
       subject.send(sender)
    }
}

extension UIControl {
    func publisher(
        for event: UIControl.Event
    ) -> UIControlPublisher<UIControl> {
         return .init(control: self, event: event)
    }
}

extension UIView {
   func assign<Value>(
       _ publisher: AnyPublisher<Value, Never>,
       to key: ReferenceWritableKeyPath<UIView, Value>
   ) -> AnyCancellable {
       return publisher.assign(to: key, on: self)
   }
}
