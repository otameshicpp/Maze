//
//  ViewController.swift
//  Maze
//
//  Created by 黒田浩揮 on 2019/08/22.
//  Copyright © 2019 黒田浩揮. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    let fromAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var count2: UILabel!
    @IBOutlet weak var count1: UILabel!
    @IBOutlet weak var count3: UILabel!
    @IBOutlet weak var start_label: UILabel!
    @IBOutlet weak var firststar: UILabel!
    @IBOutlet weak var secondstar: UILabel!
    @IBOutlet weak var thirdstar: UILabel!
    
    
    @IBOutlet weak var grayBack: UILabel!
    var playerMotionManager: CMMotionManager!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    var score: Double = 1000.0
    let defaults: UserDefaults = UserDefaults.standard
    var checkpointX: CGFloat = 0.0
    var checkpointY: CGFloat = 0.0
    var checkPointOK = false
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    let screenSize = UIScreen.main.bounds.size
    var cellwidth: CGFloat = 0.0
    var cellheight: CGFloat = 0.0
    var play_numx: Int = 0
    var play_numy: Int = 0
    let maze = [
        [2,0,1,1,1,1,1],
        [1,0,1,0,0,0,0],
        [1,0,0,0,1,0,1],
        [1,0,1,1,1,0,0],
        [1,0,1,0,0,0,1],
        [1,0,1,0,1,1,0],
        [1,0,1,0,0,0,1],
        [1,0,1,1,1,0,0],
        [1,1,1,1,0,1,0],
        [1,0,0,0,0,3,0],
        [1,1,1,1,1,1,1]
    ]
    var startView : UIView!
    var goalView : UIView!
    
    
    var wallArray = [UIView]()
    var grayArray = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firststar.isHidden=true
        secondstar.isHidden=true
        thirdstar.isHidden=true
        fromAppDelegate.option=0
        cellwidth = screenSize.width / CGFloat(maze[0].count)
        cellheight = screenSize.height / CGFloat(maze.count)
        
        let cellOffsetX = cellwidth/2
        let cellOffsetY = cellheight/2
        
        count1.isHidden=true
        count2.isHidden=true
        count3.isHidden=true
        start_label.isHidden=true
        
        grayArray.append(gray_maker(x:360.0, y: 61, width: 50, height: 60))
        grayArray[0].backgroundColor=UIColor.gray
        grayArray.append(gray_maker(x:360, y: 183, width: 50, height:60))
        grayArray[1].backgroundColor=UIColor.gray
        grayArray.append(gray_maker(x:360.0, y: 425, width: 50, height: 60))
        grayArray[2].backgroundColor=UIColor.gray
        
        
        for y in 0 ..< maze.count{
            for x in 0 ..< maze[y].count{
                switch maze[y][x]{
                case 1:
                    let wallview = creatView(x: x, y: y, width: cellwidth, height: cellheight, offsetX: cellOffsetX, offsetY: cellOffsetY)
                    
                    if x == 1 && y == 8{
                        if fromAppDelegate.ok == true{
                            wallview.backgroundColor=UIColor.purple
                        }else{
                           wallview.backgroundColor = UIColor.red
                        }

                        checkpointX = wallview.center.x
                        checkpointY = wallview.center.y
                        
                    
                    }else{

                    wallview.backgroundColor = UIColor.init(red: 0.20, green: 0.14, blue: 0.06, alpha: 1)
                    }
                    view.addSubview(wallview)
                    wallArray.append(wallview)


                case 2:
                    startView = creatView(x: x, y: y, width: cellwidth, height: cellheight, offsetX: cellOffsetX, offsetY: cellOffsetY)
                    startView.backgroundColor = UIColor.init(red: 30/255, green: 100/255, blue: 60/255, alpha: 1)
                    view.addSubview(startView)
                    defaults.set(startView.center.x, forKey: "startViewX")
                    defaults.set(startView.center.y, forKey: "startViewY")

                case 3:
                    goalView = creatView(x: x, y: y, width: cellwidth, height: cellheight, offsetX: cellOffsetX, offsetY: cellOffsetY)
                    goalView.backgroundColor = UIColor.init(red: 15/255, green: 15/255, blue: 240/255, alpha: 0.7)
                    view.addSubview(goalView)

                case 0:
                    let streetView = creatView(x: x, y: y, width: cellwidth, height: cellheight, offsetX: cellOffsetX, offsetY: cellOffsetY)
                    streetView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
                    view.addSubview(streetView)
                default:
                    break
                }
            }
        }
//        for i in 0 ..< 3{
//            view.addSubview(grayArray[i])
//            self.view.bringSubviewToFront(grayArray[i])
//        }
        
        fromAppDelegate.playerView = UIView(frame: CGRect(x: 0, y: 0, width: cellwidth / 6, height: cellheight/6))
        fromAppDelegate.playerView.center = startView.center
        fromAppDelegate.playerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        view.addSubview(fromAppDelegate.playerView)
        playerMotionManager = CMMotionManager()
        playerMotionManager.accelerometerUpdateInterval = 0.02
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        fromAppDelegate.clearNum = [0,0,0]
        score=1000.0
        fromAppDelegate.playerView.center = startView.center
        let option = fromAppDelegate.option
        if option==2{
            
            
            
                fromAppDelegate.playerView.center.x = checkpointX
                fromAppDelegate.playerView.center.y = checkpointY
            
            
        }
        defaults.set(checkpointX, forKey: "checkPointX")
        defaults.set(checkpointY, forKey: "checkPointY")
        speedX = 0.0
        speedY = 0.0
        count3.isHidden=false
        grayBack.isHidden=false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // 0.5秒後に実行したい処理
            self.count3.isHidden=true
            self.count2.isHidden=false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // 0.5秒後に実行したい処理
            self.count2.isHidden=true
            self.count1.isHidden=false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // 0.5秒後に実行したい処理
            self.count1.isHidden=true
            self.start_label.isHidden=false
            self.grayBack.isHidden=true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.start_label.isHidden=true
                self.startAcceleormeter()
            }
        }
        
        
        
    }
    func creatView(x: Int, y: Int, width: CGFloat, height: CGFloat, offsetX: CGFloat, offsetY: CGFloat) -> UIView {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let view = UIView(frame: rect)
        let center = CGPoint(x: offsetX + width * CGFloat(x), y: offsetY + height * CGFloat(y))
        view.center = center
        return view
    }
    
    func startAcceleormeter(){
        let handler: CMAccelerometerHandler = {(CMAccelerometerData: CMAccelerometerData?, error: Error?) -> Void in
            self.speedX += CMAccelerometerData!.acceleration.x
            
            self.speedY += CMAccelerometerData!.acceleration.y
            
            self.posX = self.fromAppDelegate.playerView.center.x + (CGFloat(self.speedX)/5)

            
            self.posY = self.fromAppDelegate.playerView.center.y - (CGFloat(self.speedY)/5)
            
            if self.posX <= self.fromAppDelegate.playerView.frame.width/2{
                self.speedX = 0
                self.posX = self.fromAppDelegate.playerView.frame.width/2
            }
            
            if self.posY <= self.fromAppDelegate.playerView.frame.height/2{
                self.speedY = 0
                self.posY = self.fromAppDelegate.playerView.frame.height/2
            }
            
            if self.posX >= self.screenSize.width - (self.fromAppDelegate.playerView.frame.width/2){
                self.speedX = 0
                self.posX = self.screenSize.width - (self.fromAppDelegate.playerView.frame.width/2)
            }
            
            if self.posY >= self.screenSize.height - (self.fromAppDelegate.playerView.frame.height/2){
                self.speedY = 0
                self.posY = self.screenSize.height - (self.fromAppDelegate.playerView.frame.height/2)
            }
            
            self.score-=0.2
            var what_for: Int = 0
            for wall in self.wallArray{
                what_for+=1
                if wall.frame.intersects(self.fromAppDelegate.playerView.frame){
                    if what_for==30 {
                        wall.backgroundColor = UIColor.purple
                        self.checkPointOK = true
                        self.fromAppDelegate.ok = true
                    }else{
                    self.gamecheck(result: "GAME OVER...", message: "壁に当たりました")
                    return
                    }
                }
            }
            var what_g: Int = 0
            for wall in self.grayArray{
                what_g+=1
                if wall.frame.intersects(self.fromAppDelegate.playerView.frame){
                    self.fromAppDelegate.clearNum[what_g-1]=1
                }
                
            }
            if self.goalView.frame.intersects(self.fromAppDelegate.playerView.frame){
                self.defaults.set(self.score, forKey: "scores4")
                self.performSegue(withIdentifier: "toKekka", sender: nil)
                
                return
            }
            
            
            self.fromAppDelegate.playerView.center = CGPoint(x: self.posX, y:self.posY)
        }
        
        for y in 0 ..< maze.count{
            for x in 0 ..< maze[y].count{
                if maze[y][x] != 2||maze[y][x] != 3{
                    
                }
            }
        }
        playerMotionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handler)
    }
    func gamecheck(result: String, message: String){
        if playerMotionManager.isAccelerometerActive {
            playerMotionManager.stopAccelerometerUpdates()
        }
        
        self.performSegue(withIdentifier: "toGameOver", sender: nil)
        
//        let gameCheckAlert: UIAlertController = UIAlertController(title: result, message: message, preferredStyle: .alert)
//        let retryAction = UIAlertAction(title: "もう一度？", style: .default, handler: {(action: UIAlertAction) -> Void in
//            self.retry()
//        })
//        gameCheckAlert.addAction(retryAction)
//
//        present(gameCheckAlert, animated: true, completion: nil)
    }
    
    
    func whereIsThePlayer(x: CGFloat, y: CGFloat){
        play_numx = Int(Double(x)/Double(cellwidth))
        play_numy = Int(Double(y)/Double(cellheight))
    }
    func gray_maker(x:CGFloat,y:CGFloat,width:CGFloat,height: CGFloat) -> UIView{
        let gray_check1:CGRect = CGRect(x:x, y: y, width: width, height: height)
        let gray_view1: UIView = UIView(frame: gray_check1)
        return gray_view1
    }
}

