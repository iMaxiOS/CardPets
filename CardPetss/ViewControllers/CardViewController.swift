//
//  CardViewController.swift
//  CardPetss
//
//  Created by Гранченко Максим on 12/10/18.
//  Copyright © 2018 Гранченко Максим. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    static let cardCornerRadius: CGFloat = 25
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int?
    var petCard: PetCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = petCard?.description
        cardView.layer.cornerRadius = CardViewController.cardCornerRadius
        cardView.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segueIdentifier(for: segue) == .reveal,
            let destinationViewController = segue.destination as? RevealViewController {
            destinationViewController.petCard = petCard
            destinationViewController.transitioningDelegate = self
        }
    }
    
    @IBAction func handleTap() {
        performSegue(withIdentifier: .reveal, sender: nil)
    }
}

extension CardViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case reveal
    }
}

extension CardViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController(originFrame: cardView.frame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let revealVC = dismissed as? RevealViewController else {
            return nil
        }
        return FlipDismissAnimationController(destinationFrame: cardView.frame, interactionController: revealVC.swipeInteractionController)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? FlipDismissAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }
    
}
