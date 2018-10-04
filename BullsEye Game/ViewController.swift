//
//  ViewController.swift
//  BullsEye Game
//
//  Created by ＫＫＤＳ on 2016/12/21.
//  Copyright © 2016年 KKDS. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0 , left: 14, bottom: 0 , right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        startNewRound()
        updateLables()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs( currentValue - targetValue)
        let points = 100 - difference
        var message: String
        if points == 100{
            score = score + points + 100
            message = "Your Score is : \(points + 100)"
        }else{
            score += points
            message = "Your Score is: \(points)"
        }
        
        var tips: String = ""
        if difference <= 10 {
            tips = "Very Close!"
        } else if difference == 0{
            tips = "Excellent!"
        } else {
            tips = "Need more exercise."
        }
        
        
        
        let alert = UIAlertController( title: tips,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction( title: "OK",
                                    style: .default,
                                    handler: {
                                        action in
                                        self.startNewRound()
                                        self.updateLables()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }

    @IBAction func UISliderMoved(_ slider: UISlider){
        
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func reset(){
        score = 0
        round = 0
        startNewRound()
        updateLables()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateLables(){
        targetLable.text = String(targetValue)
        scoreLable.text = String(score)
        roundLable.text = String(round)
    }
    
    
}

