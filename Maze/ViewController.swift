//
//  ViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/22.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    let fromAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("hoge")
        fromAppDelegate.option=0
    }
    
}

