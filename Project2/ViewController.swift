//
//  ViewController.swift
//  Project2
//
//  Created by Azat Kaiumov on 17.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var round = 0
    var score = 0
    var correctAnswerIndex = 0
    var correctCountry: String {
        countries[correctAnswerIndex]
    }
    
    var countries = [
        "estonia",
        "france",
        "germany",
        "ireland",
        "italy",
        "monaco",
        "nigeria",
        "poland",
        "russia",
        "spain",
        "uk",
        "us"
    ]
    
    func updateTitle() {
        title = "\(correctCountry.uppercased()). Score: \(score)"
    }
    
    func askQuestion() {
        round += 1
        countries.shuffle()
        correctAnswerIndex = Int.random(in: 0...2)
        updateTitle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Score",
            style: .done,
            target: self,
            action:  #selector(shareButtonTapped)
        )
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func shareButtonTapped() {
        let alert = UIAlertController(
            title: "Score",
            message: "Your score is: \(score)",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Close",
                style: .default
            )
        )
        
        present(alert, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var messageRightCountry: String?
        let selectedAnswerIndex = sender.tag
        
        if selectedAnswerIndex == correctAnswerIndex {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong!"
            score -= 1
            let actualCountry = countries[selectedAnswerIndex]
            messageRightCountry = "That’s the flag of \(actualCountry.uppercased())"
        }
        
        let messageScore: String
        
        if round == 10 {
            messageScore = "Your final score is \(score)"
        } else {
            messageScore = "Your score is \(score)"
        }
        
        let message: String
        
        if let messageRightCountry = messageRightCountry {
            message = "\(messageRightCountry)\n\(messageScore)"
        } else {
            message = messageScore
        }
        
        updateTitle()
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Continue",
                style: .default,
                handler: { _ in
                    self.askQuestion()
                }
            )
        )
        
        present(alertController, animated: true)
    }
}

