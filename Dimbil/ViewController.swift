//
//  ViewController.swift
//  Dimbil
//
//  Created by Yash Nayak on 10/12/18.
//  Copyright © 2018 Yash Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var diamond1: UIImageView!
    @IBOutlet weak var diamond2: UIImageView!
    
    @IBOutlet weak var diamond3: UIImageView!
    @IBOutlet weak var diamond4: UIImageView!
    @IBOutlet weak var diamond5: UIImageView!
    @IBOutlet weak var diamond6: UIImageView!
    @IBOutlet weak var diamond7: UIImageView!
    @IBOutlet weak var diamond8: UIImageView!
    @IBOutlet weak var diamond9: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var diamondArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = "Your Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        
        diamond1.addGestureRecognizer(recognizer1)
        diamond2.addGestureRecognizer(recognizer2)
        diamond3.addGestureRecognizer(recognizer3)
        diamond4.addGestureRecognizer(recognizer4)
        diamond5.addGestureRecognizer(recognizer5)
        diamond6.addGestureRecognizer(recognizer6)
        diamond7.addGestureRecognizer(recognizer7)
        diamond8.addGestureRecognizer(recognizer8)
        diamond9.addGestureRecognizer(recognizer9)
        
        diamond1.isUserInteractionEnabled = true
        diamond2.isUserInteractionEnabled = true
        diamond3.isUserInteractionEnabled = true
        diamond4.isUserInteractionEnabled = true
        diamond5.isUserInteractionEnabled = true
        diamond6.isUserInteractionEnabled = true
        diamond7.isUserInteractionEnabled = true
        diamond8.isUserInteractionEnabled = true
        diamond9.isUserInteractionEnabled = true
        
        
        counter = 30
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hidediamond), userInfo: nil, repeats: true)
        
        
        diamondArray.append(diamond1)
        diamondArray.append(diamond2)
        diamondArray.append(diamond3)
        diamondArray.append(diamond4)
        diamondArray.append(diamond5)
        diamondArray.append(diamond6)
        diamondArray.append(diamond7)
        diamondArray.append(diamond8)
        diamondArray.append(diamond9)
        
        hidediamond()
        
    }
    
    
    @objc func increaseScores() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highScoreLabel.text!)! {
                
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Your Time Is Up", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                
                
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hidediamond), userInfo: nil, repeats: true)
                
            })
            
            alert.addAction(replay)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func hidediamond() {
        
        for diamond in diamondArray {
            diamond.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(diamondArray.count - 1)))
        diamondArray[randomNumber].isHidden = false
    }
    
    

}

