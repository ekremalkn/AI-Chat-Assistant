//
//  AssistantsViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import Foundation

protocol AssistantsViewModelInterface {
    var view: AssistantsViewInterface? { get set }
    
    func viewDidLoad()
    
}

final class AssistantsViewModel {
    
    //MARK: - References
    var view: AssistantsViewInterface?

}

//MARK: - AssistantsViewModelInterface
extension AssistantsViewModel: AssistantsViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    
}
