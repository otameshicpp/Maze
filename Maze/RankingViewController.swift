//
//  RankingViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/25.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet weak var ranking1: UILabel!
    @IBOutlet weak var ranking2: UILabel!
    @IBOutlet weak var ranking3: UILabel!
    
    let defaults = UserDefaults.standard
    let startColor = UIColor(red: 191/255, green: 250/255, blue: 57/255, alpha: 1).cgColor
    let endColor = UIColor(red: 62/255, green: 176/255, blue: 47/255, alpha: 1).cgColor
    let layer_p = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        layer_p.colors = [endColor,startColor]
        layer_p.frame = view.bounds
        self.view.layer.insertSublayer(layer_p, at:0)
        ranking1.text = "Score : " + String(defaults.integer(forKey: "score1"))
        ranking2.text = "Score : " + String(defaults.integer(forKey: "score2"))
        ranking3.text = "Score : " + String(defaults.integer(forKey: "score3"))
        // Do any additional setup after loading the view.
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
