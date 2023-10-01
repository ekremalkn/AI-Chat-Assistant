//
//  SplashViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 1.10.2023.
//

import UIKit

final class SplashViewController: UIViewController {

    //MARK: - References
    weak var splashCoordinator: SplashCoordinator?
    private let splashView = SplashView()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        splashView.animateAppLogo(duration: 0.75) { [weak self] in
            guard let self else { return }
            splashCoordinator?.setRootViewControllerToMainTabBarController()
        }
    }
    


}
