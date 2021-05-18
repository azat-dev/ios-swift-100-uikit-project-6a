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
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswerIndex {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let message: String
        
        if round == 10 {
            message = "Your final score is \(score)"
        } else {
            message = "Your score is \(score)"
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

