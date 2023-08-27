//
//  HomeViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation

protocol  HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
}

final class HomeViewModel {
    
    //MARK: - References
    weak var view: HomeViewInterface?
    
    //MARK: - Init Methods
    init() {
        
    }


}

//MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    func numberOfItems() -> Int {
        0
    }
    
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    
}
