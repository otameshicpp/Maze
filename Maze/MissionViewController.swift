//
//  MissionViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/25.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit

class MissionViewController: UIViewController {
    
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var gohoubiLabel: UILabel!
    
    
    let startColor = UIColor(red: 161/255, green: 140/255, blue: 209/255, alpha: 1).cgColor
    let endColor = UIColor(red: 115/255, green: 62/255, blue: 47/255, alpha: 1).cgColor
    let layer_p = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        layer_p.colors = [endColor,startColor]
        layer_p.frame = view.bounds
        self.view.layer.insertSublayer(layer_p, at:0)
        missionLabel.isHidden=false
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func totop(_ sender: Any) {
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
