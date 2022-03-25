//
//  ViewModel.swift
//  MVVM_Combine
//
//  Created by Felipe Montoya on 3/24/22.
//

import Foundation
import Combine



/// ViewModel for ViewController
/// Function A makes a Title
struct ViewModel {
    
    /*enum State { //Snapshot
        case idle
        case loading(String)
        case waiting(String)
    }*/

    // Subscribes  < - - -  Publishers < - - -  Flow of Data
    //MARK: - Public Properties and Methods -
    public var titleState = PassthroughSubject<String, Never>()
    
    public mutating func getNewTitle(){
        calculateState()
    }
    
    
    
    //count, model, data, image ....
    
    //Calcular y compartir estado del View.
    init() {
        //logica al inicializar
        self.title = ""
    }
    
    //MARK: - Private Properties and Methods -
    //TODO: Implement interaction
    //FIXME: Error when calling api
    
    fileprivate var title: String {
        didSet {
            titleState.send(title)
        }
    }
    
    
    mutating private func calculateState() {
        let element = Double.random(in: 0.0...100.0)
        title =  String(element)
    }
}
