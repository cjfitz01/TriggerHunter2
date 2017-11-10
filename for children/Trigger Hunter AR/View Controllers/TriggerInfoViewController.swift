//
//  TriggerInfoViewController.swift
//  Trigger Hunter AR
//
//  Created by Cal Stephens on 11/9/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit


class TriggerInfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var triggerImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var trigger: Trigger!
    var didTapNextBlock: (() -> Void)?
    
    // MARK: Setup
    
    static func create(
        for trigger: Trigger,
        didTapNextBlock: @escaping () -> Void) -> TriggerInfoViewController
    {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "Trigger Info") as! TriggerInfoViewController
        viewController.didTapNextBlock = didTapNextBlock
        viewController.trigger = trigger
        return viewController
    }
    
    override func viewDidLoad() {
        titleLabel.text = "How to avoid \(trigger.pluralizedName)"
        triggerImageView.image = trigger.image
        
        textView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
        textView.attributedText = trigger.attributedDescription
    }
    
    // MARK: User Interaction
    
    @IBAction func userDidTapNextButton() {
        didTapNextBlock?()
    }
    
}

// MARK: Trigger+AttributedDescription

extension Trigger {
    
    var attributedDescription: NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(
            string: self.backgroundText + "\n\n",
            attributes: [.font: UIFont.systemFont(ofSize: 18)]))
        
        let bulletParagraphStyle = NSMutableParagraphStyle()
        bulletParagraphStyle.paragraphSpacing = 10
        bulletParagraphStyle.headIndent = 25
        
        attributedString.append(NSAttributedString(
            string: "Action Plan\n",
            attributes: [
                .font: UIFont.systemFont(ofSize: 23, weight: .semibold),
                .paragraphStyle: bulletParagraphStyle]))
        
        self.actionPlan.forEach { actionPlanItem in
            attributedString.append(NSAttributedString(
                string: "  •  \(actionPlanItem)\n",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18),
                    .paragraphStyle: bulletParagraphStyle]))
        }
        
        return attributedString
    }
    
}
