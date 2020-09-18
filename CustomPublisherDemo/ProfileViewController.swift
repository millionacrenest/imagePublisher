//
//  ProfileViewController.swift
//  CustomPublisherDemo
//
//  Created by McEntire, Allison on 9/17/20.
//  Copyright © 2020 Deloitte Digital. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let interactor: Interactor

    init(interactor: Interactor) {
         self.interactor = interactor
         super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("") }

    override func loadView() {
         let viewModel = interactor.viewModel()
         let mainView = MainView(viewModel: viewModel)
         self.view = mainView
    }
    

}
