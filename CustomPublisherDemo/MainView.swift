//
//  MainView.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/18/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import Combine
import UIKit
import Foundation

struct MainViewModel {
    let buttonAction: AnySubscriber<Void, Never>
    let buttonColor: AnyPublisher<UIColor?, Never>
}

class MainView: UIView {
    private var button = UIButton()
    private var cancallables = Set<AnyCancellable>()
    private var buttonPublisher: AnyPublisher<Void, Never>
    
    init(viewModel: MainViewModel) {
        buttonPublisher = button.publisher(for: .touchUpInside)
            .map { _ in Void() }
            .eraseToAnyPublisher()

        buttonPublisher.subscribe(viewModel.buttonAction)
        super.init(frame: .zero)
        buildButton()
        
        button.assign(viewModel.buttonColor, to: \.backgroundColor)
            .store(in: &cancallables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Color", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
