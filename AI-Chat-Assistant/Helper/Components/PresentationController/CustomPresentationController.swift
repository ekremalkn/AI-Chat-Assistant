//
//  CustomPresentationController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

final class CustomPresentationController: UIPresentationController {

    private let presentationHeightPercentage: CGFloat // İçeriğin yüksekliği için yüzde değeri
    private var dimmingView: UIView? // Arka planı kaplamak için kullanılacak görünüm

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, presentationHeightPercentage: CGFloat) {
        self.presentationHeightPercentage = presentationHeightPercentage
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    override func presentationTransitionWillBegin() {
        // Arka planı kaplamak için siyah bir görünüm ekleyin
        dimmingView = UIView(frame: containerView!.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView?.addSubview(dimmingView!)

        // Sunum başladığında arka planı animasyonla gösterin
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView?.alpha = 1.0
            }, completion: nil)
        }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        // Sunum tamamlandığında başarılıysa arka planı silin
        if !completed {
            dimmingView?.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        // Sunum kapanmaya başladığında arka planı animasyonla gizleyin
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView?.alpha = 0.0
            }, completion: nil)
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // Sunum kapanırsa arka planı silin
        if completed {
            dimmingView?.removeFromSuperview()
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }

        // İçeriğin yüksekliğini yüzdeye göre ayarlayın
        let height = containerView.bounds.height * presentationHeightPercentage
        let originY = containerView.bounds.height - height
        return CGRect(x: 0, y: originY, width: containerView.bounds.width, height: height)
    }
}


