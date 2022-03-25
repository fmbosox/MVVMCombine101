//
//  ViewController.swift
//  MVVM_Combine
//
//  Created by Felipe Montoya on 3/24/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var viewModel: ViewModel = UIDependencyInjector.getViewModelForHome()
    private var cancellables: [AnyCancellable] = []
    
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "-----"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    lazy var button: UIButton  = {
        let button = UIButton(configuration: .borderedProminent(),
                              primaryAction: UIAction.init(handler: { _ in  self.viewModel.getNewTitle() }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Model Interaction", for: .normal)
        return button
    }()
    
    fileprivate func setLayout() {
        //Primero agregar a subview
        self.view.addSubview(label)
        self.view.addSubview(button)
        
        
        //Segundo: translatesAutoresizingMaskIntoConstraints = false
        //OK
        
        //Activate constraint
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50.0)
        ])
    }
    
    fileprivate func bind() {
        self.viewModel
            .titleState
            .map({ string in
                return "Mapped Title: " + string
            })
            .sink { title in
                self.updateUI(title)
            }
            .store(in: &cancellables)
        
    }
    
    fileprivate func updateUI(_ title: String) {
        label.text = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        bind()
        
    }


}

