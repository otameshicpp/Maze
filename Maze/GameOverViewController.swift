//
//  GameOverViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/24.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    let startColor = UIColor(red: 28/255, green: 181/255, blue: 224/255, alpha: 1).cgColor
    let endColor = UIColor(red: 0/255, green: 0/255, blue: 70/255, alpha: 1).cgColor
    let layer_p = CAGradientLayer()
    let defaults = UserDefaults.standard
    let fromAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var usingCheckPointButton: UIButton!
    
    var useCheckPoint = false
    override func viewDidLoad() {
        super.viewDidLoad()
        layer_p.colors = [endColor,startColor]
        layer_p.frame = view.bounds
        self.view.layer.insertSublayer(layer_p, at:0)
        
        
        if fromAppDelegate.ok==false{
            usingCheckPointButton.isEnabled = false
            usingCheckPointButton.isHidden = true
        }else{
            usingCheckPointButton.isEnabled = true
            usingCheckPointButton.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    @IBAction func toTop(_ sender: Any) {
        fromAppDelegate.option=10
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func toGameView(_ sender: Any) {
        useCheckPoint = false
        fromAppDelegate.option=1
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func usingCheckPoint(_ sender: Any) {
        useCheckPoint = true
        fromAppDelegate.option=2
        print("入力済み：\(fromAppDelegate.option)")
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
