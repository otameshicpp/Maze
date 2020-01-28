//
//  RuleViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/24.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {
    
    @IBOutlet weak var rule1: UILabel!
    @IBOutlet weak var rule2: UILabel!
    @IBOutlet weak var rule3: UILabel!
    @IBOutlet weak var rule4: UILabel!
    
    @IBOutlet weak var rule3_p2: UILabel!
    @IBOutlet weak var rule3_p1: UILabel!
    @IBOutlet weak var rule4_p: UILabel!
    
    
    let startColor = UIColor(red: 28/255, green: 181/255, blue: 224/255, alpha: 1).cgColor
    let endColor = UIColor(red: 0/255, green: 0/255, blue: 70/255, alpha: 1).cgColor
    let layer_p = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        layer_p.colors = [endColor,startColor]
        layer_p.frame = view.bounds
        self.view.layer.insertSublayer(layer_p, at:0)
        rule1.center.x = -1000.0
        rule2.center.x = 2000.0
        rule3.center.x = -1000.0
        rule4.center.x = 2000.0
        rule3_p1.center.x = -1000.0
        rule3_p2.center.x = -1000.0
        rule4_p.center.x = 2000.0
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.rule1.center.x = 190.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.rule2.center.x = 190.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseOut, animations: {
            self.rule3.center.x = 190.0
            self.rule3_p1.center.x = 190.0
            self.rule3_p2.center.x = 190.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
            self.rule4.center.x = 230.0
            self.rule4_p.center.x = 230.0
        }, completion: nil)
    }

    @IBAction func toTop(_ sender: Any) {
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
