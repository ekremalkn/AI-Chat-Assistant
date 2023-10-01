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
    private let onboardingView = OnboardingView()
    
    //MARK: - Life Cycle Methods
    init() {
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
        setupDelegates()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onboardingView.startLabelAnimations {
            
        }
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        onboardingView.delegate = self
    }

    
    
}

//MARK: - OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func onboardingView(_ view: OnboardingView, continueButtonTapped button: UIButton) {
        onboardingCoordinator?.setRootViewControllerToMainTabBarController()
    }
    
}
