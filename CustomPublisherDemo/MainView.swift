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
    private var imageView = UIImageView()
    private var cancallables = Set<AnyCancellable>()
    private var buttonPublisher: AnyPublisher<UIImage, Never>
    //private var imagePublisher: AnyPublisher<Void, Never>
    
    private var imageModel = ProfileViewModel()
    
    init(viewModel: MainViewModel) {
        buttonPublisher = button.publisher(for: .touchUpInside)
            .map { _ in UIImage(systemName: "xmark")! as UIImage }
            .eraseToAnyPublisher()
        
        

        
        super.init(frame: .zero)
        buildImageView()
        buildButton()
        
        
        buttonPublisher.assign(to: \.image, on: imageView)
        
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
    
    private func buildImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}
