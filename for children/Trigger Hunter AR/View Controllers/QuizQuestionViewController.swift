//
//  QuizQuestionViewController.swift
//  Trigger Hunter AR
//
//  Created by Cal Stephens on 11/12/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit

// MARK: QuizQuestionViewControllerDelegate

protocol QuizQuestionViewControllerDelegate: class {
    
}

// MARK: QuizQuestionViewController

class QuizQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerOneView: UIView!
    @IBOutlet weak var answerTwoView: UIView!
    @IBOutlet weak var answerThreeView: UIView!
    @IBOutlet weak var answerFourView: UIView!
    
    @IBOutlet weak var answerOneLabel: UILabel!
    @IBOutlet weak var answerTwoLabel: UILabel!
    @IBOutlet weak var answerThreeLabel: UILabel!
    @IBOutlet weak var answerFourLabel: UILabel!
    
    private func answerView(at index: Int) -> (background: UIView, label: UILabel)? {
        switch index {
        case 0: return (answerOneView, answerOneLabel)
        case 1: return (answerTwoView, answerTwoLabel)
        case 2: return (answerThreeView, answerThreeLabel)
        case 3: return (answerFourView, answerFourLabel)
        default: return nil
        }
    }
    
    var question: Question!
    var correctAnswerIndex: Int?
    
    weak var delegate: QuizQuestionViewControllerDelegate?
    
    
    // MARK: Presentation
    
    static func create(for question: Question) -> QuizQuestionViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "Quiz Question") as! QuizQuestionViewController
        viewController.question = question
        return viewController
    }
    
    // MARK: Setup
    
    override func viewDidLoad() {
        let answers = question.allAnswers.shuffled
        correctAnswerIndex = answers.index(of: question.correctAnswer)!
        
        for (index, answer) in answers.enumerated() {
            answerView(at: index)?.label.text = answer
        }
        
        questionLabel.text = question.text
    }
    
    // MARK: User Interaction
    
    enum TouchState {
        case down, up
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches, state: .down)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches, state: .down)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches, state: .up)
    }
    
    func handleTouches(_ touches: Set<UITouch>, state: TouchState) {
        guard let touch = touches.first else { return }
        
        for index in [0, 1, 2, 3] {
            guard let answerView = answerView(at: index) else { continue }
            let touchLocation = touch.location(in: answerView.background)
            let touchIsInView = answerView.background.bounds.contains(touchLocation)
            
            if state == .down {
                answerView.background.backgroundColor = touchIsInView ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                answerView.background.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                if touchIsInView {
                    userDidTapAnswer(at: index)
                }
            }
        }
    }
    
    func userDidTapAnswer(at index: Int) {
        print(index)
    }
    
}
