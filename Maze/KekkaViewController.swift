//
//  KekkaViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/24.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit

class KekkaViewController: UIViewController {

    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var HighScore: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number1: UILabel!
    let screenSize = UIScreen.main.bounds.size
    let startColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor
    let endColor = UIColor(red: 109/255, green: 117/255, blue: 120/255, alpha: 1).cgColor
    @IBOutlet weak var usingCheckPointButton: UIButton!
    let fromAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let defaults: UserDefaults = UserDefaults.standard
    let layer_p = CAGradientLayer()
    var score: Int = 0
    var scoretable: [Int] = [0,0,0,0]
    
    var start: CGFloat!
    var startY: CGFloat!
    var checkPointX: CGFloat!
    var checkPointY: CGFloat!
    var highScore: Bool = false
    var clearnum: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let preVC = fromAppDelegate.ok
        if !preVC{
            usingCheckPointButton.isEnabled = false
            usingCheckPointButton.isHidden = true
        }else{
            usingCheckPointButton.isEnabled = true
            usingCheckPointButton.isHidden = false
        }
        for i in fromAppDelegate.clearNum{
            clearnum+=i
        }
        star1.isHidden=true
        star2.isHidden=true
        star3.isHidden=true
        if fromAppDelegate.option == 2{
            clearnum-=1
        }
        
        scoreLabel.center.x=1125
        highScore=false
        layer_p.colors = [startColor,endColor]
        layer_p.frame = view.bounds
        self.view.layer.insertSublayer(layer_p, at:0)
        score = defaults.integer(forKey: "scores4")
        score+=(200*clearnum)
        scoreLabel.text = "SCORE : " + String(score)
        scoretable[0] = defaults.integer(forKey: "score1")
        scoretable[1] = defaults.integer(forKey: "score2")
        scoretable[2] = defaults.integer(forKey: "scores3")
        scoretable[3] = score
        if scoretable[0] < scoretable[3] {
            highScore = true
        }
        scoretable.sort { $0 > $1 }
        number1.text = "1位 : "+String(scoretable[0])
        number2.text = "2位 : "+String(scoretable[1])
        number3.text = "3位 : "+String(scoretable[2])
        defaults.set(scoretable[0], forKey: "score1")
        defaults.set(scoretable[1], forKey: "score2")
        defaults.set(scoretable[2], forKey: "scores3")
        number1.center.x = 1125
        number2.center.x = 1125
        number3.center.x = 1125
        HighScore.alpha = 0.0

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.scoreLabel.center.x = self.screenSize.width/2
                    }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.number1.center.x = self.screenSize.width/2
            self.number2.center.x = self.screenSize.width/2
            self.number3.center.x = self.screenSize.width/2
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut, animations: {
            if self.highScore{
            self.HighScore.alpha = 1
            }
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseOut, animations: {
            if self.clearnum>0{
            self.star1.isHidden=false
            }
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 2.5, options: .curveEaseOut, animations: {
            if self.clearnum >= 2{
            self.star2.isHidden=false
            }
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 3.5, options: .curveEaseOut, animations: {
            if self.clearnum == 3{
                self.star3.isHidden=false
            }
        }, completion: nil)


        start = CGFloat(defaults.float(forKey: "startViewX"))
        startY = CGFloat(defaults.float(forKey: "startViewY"))
        checkPointX = CGFloat(defaults.float(forKey: "checkPointX"))
        checkPointY = CGFloat(defaults.float(forKey: "checkPointY"))
        
    }
    
    
    
    @IBAction func to_top(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func retryNormal(_ sender: Any) {
        fromAppDelegate.option = 1
        defaults.set(1, forKey: "option")
        fromAppDelegate.playerView.center.x = start
        fromAppDelegate.playerView.center.y = startY
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func retryUsingCheckPoint(_ sender: Any) {
        fromAppDelegate.option = 2
        defaults.set(2, forKey: "option")
        fromAppDelegate.playerView.center.x = checkPointX
        fromAppDelegate.playerView.center.y = checkPointY
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
