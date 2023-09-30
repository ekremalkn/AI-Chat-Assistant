//
//  OnboardingViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 30.09.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - References
    weak var onboardingCoordinator: OnboardingCoordinator?
    private let viewModel: OnboardingViewModel
    private let onboardingView = OnboardingView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
