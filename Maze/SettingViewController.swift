//
//  SettingViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2020/02/04.
//  Copyright © 2020 黒田浩揮. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var ma: UISlider!
    @IBOutlet weak var masalabel: UILabel!
    let feedbackgenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    override func viewDidLoad() {
        super.viewDidLoad()
        ma.value=Float(fromAppDelegate.haya)
        
        masalabel.text="プレーヤーの速さ：\(fromAppDelegate.haya+1)"
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // インスタンスを生成し prepare() をコール

        self.feedbackgenerator.prepare()
    }
    let fromAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func masatsu(_ sender: Any) {
        
//        print(ma.value)
//        print("\n")
        let step: Float = 1
        let roundedValue = round(ma.value/step) * step
        ma.value = roundedValue
//        print(ma.value)
        if Int(ma.value) != fromAppDelegate.haya {
//            print("\(10-Int((fromAppDelegate.masa-1.0)*100))  \(10-Int((Double(1.1-(ma.value-1.0))-1.0)*100))")
            self.feedbackgenerator.impactOccurred()
            fromAppDelegate.haya=Int(ma.value)
        }
        
        fromAppDelegate.masa = Double(1.09-ma.value*0.02)
//        print(fromAppDelegate.masa)
        masalabel.text="プレーヤーの速さ：\(fromAppDelegate.haya+1)"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 一応 nil にしておく
        
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
