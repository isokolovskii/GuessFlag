//
//  ViewController.swift
//  GuessFlag
//
//  Created by Иван Соколовский on 27.11.2022.
//

import UIKit

fileprivate let MAX_PLAY_COUNT = 10

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label: UILabel!
    
    var countries: [String] = []
    var score = 0 {
        didSet {
            title = "Score: \(score)"
        }
    }
    var correctAnswer = 0 {
        didSet {
            label.text = countries[correctAnswer].uppercased()
        }
    }
    var playCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "usa"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        startGame(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
                
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func startGame(action: UIAlertAction!) {
        score = 0
        askQuestion(action: action)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var alertTitle: String
        var alertMessage: String
    
        playCount += 1
        if sender.tag == correctAnswer {
            alertTitle = "Correct"
            alertMessage = "Correctly selected \(countries[correctAnswer].uppercased())"
            score += 1
        } else {
            alertTitle = "Wrong"
            alertMessage = "You chose \(countries[sender.tag].uppercased()) instead of \(countries[correctAnswer].uppercased())."
            score -= 1
        }
        title = "Score: \(score)"
        
        let ac: UIAlertController
        if (playCount == MAX_PLAY_COUNT) {
            ac = UIAlertController(title: "Game over!", message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Retry", style: .default, handler: startGame))
        } else {
            ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Your score is", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}

