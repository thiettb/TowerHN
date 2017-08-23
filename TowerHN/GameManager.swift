//
//  GameManager.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit
import AVFoundation
class GameManager: UIViewController {
    
    //MARK:: Parametters - User
    var tower = Tower()
    var disk = DiskView()
    var status : Bool = true
    var dataCount = String()
    var moves = [Move]()
    var i = 0
    var countA : Int = 0
    var countB = 0
    var countC = 0
    var click = 0
    var audioPlayer = AVAudioPlayer()
    
    //MARK:: Parametter - UI
    var lblTitle = UILabel()
    var lblSelectCount_Disk = UILabel()
    var btnMove = UIButton()
    var textField = UITextField()
    let picker = UIPickerView()
    var bird = UIImageView()
    @IBOutlet weak var tf_input: UITextField!
    @IBOutlet weak var run: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    
    //MARK:: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.run.layer.masksToBounds = true
        self.run.layer.cornerRadius = 10
        self.run.backgroundColor = UIColor.green
        
        self.clear.layer.masksToBounds = true
        self.clear.layer.cornerRadius = 10
        self.clear.backgroundColor = UIColor.green
        self.clear.alpha = 0.0
        
        self.tf_input.placeholder = "disks"
        
        
        self.view.addSubview(tower)
        
        
    }

    //MARK:: Methods - ButtonForAnimation
    @IBAction func RunAnimation(_ sender: Any) {
        let input = tf_input.text
        if (input?.isEmpty)!{
            let alert = UIAlertController(title: "Error", message: "Bạn chưa chọn số lượng đĩa", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
            self.present(alert, animated: true, completion: nil)
        }
        else if input == "1" || input == "2" || input == "0"{
            let alert = UIAlertController(title: "Error", message: "Số lượng đĩa phải lớn hơn 3", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if input == "3"{
            if self.click == 0{
                self.countA = 3
                self.initDisk(count: 3)
                self.run.alpha = 0.0
                
                self.animation()
                
                let delayInSeconds = Double(moves.count * 6)
                self.playSong()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.clear.alpha = 1.0
                }
                click += 1
            }
            else{
                print("done")
            }
        }
        else if input == "4"{
            if self.click == 0{
                self.countA = 4
                self.initDisk(count: 4)
                click += 1
                self.animation()
                let delayInSeconds = Double(moves.count * 6)
                self.run.alpha = 0.0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.clear.alpha = 1.0
                }
                self.playSong()
            }
            else{
                print("done")
            }
        }
        else if input == "5"{
            if self.click == 0{
                self.countA = 5
                self.initDisk(count: 5)
                click += 1
                self.run.setTitle("Pause", for: .normal)
                self.animation()
                self.run.alpha = 0.0
                let delayInSeconds = Double(moves.count * 6)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.clear.alpha = 1.0
                    
                }
                self.playSong()
            }
            else{
                print("done")
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Số lượng đĩa phải lớn hơn 3 và nhỏ hơn 6", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK:: Methods - ButtonForRebuild
    @IBAction func Clear(_ sender: Any) {
        
        self.click = 0
        
        self.bird.removeFromSuperview()
        
        if tf_input.text == "3"{
            self.tower.diskArray[0].removeFromSuperview()
            self.tower.diskArray[1].removeFromSuperview()
            self.tower.diskArray[2].removeFromSuperview()
        }
        else if tf_input.text == "4"{
            self.tower.diskArray[0].removeFromSuperview()
            self.tower.diskArray[1].removeFromSuperview()
            self.tower.diskArray[2].removeFromSuperview()
            self.tower.diskArray[3].removeFromSuperview()
        }
        else if tf_input.text == "5"{
            self.tower.diskArray[0].removeFromSuperview()
            self.tower.diskArray[1].removeFromSuperview()
            self.tower.diskArray[2].removeFromSuperview()
            self.tower.diskArray[3].removeFromSuperview()
            self.tower.diskArray[4].removeFromSuperview()
        }
        self.tower.diskTempTowerA_Array.removeAll()
        self.tower.diskTempTowerB_Array.removeAll()
        self.tower.diskTempTowerC_Array.removeAll()
        self.tower.diskArray.removeAll()
        self.tower.removeFromSuperview()
        self.run.alpha = 1.0
        self.clear.alpha = 0.0
        self.moves.removeAll()
        self.countC = 0
        self.i = 0
        
    }
    
    
    
    //MARK:: Methods - UserInitDisk
    
    func initDisk(count: Int){
        var disks = [Disk]()
        if count == 3{
            disks = [
                Disk(1),
                Disk(2),
                Disk(3) ]
        }
        else if count == 4{
            disks = [
                Disk(1),
                Disk(2),
                Disk(3),
                Disk(4) ]
        }
        else if count == 5{
            disks = [
                Disk(1),
                Disk(2),
                Disk(3),
                Disk(4),
                Disk(5) ]
        }
        // Khởi tạo tháp: trong đó tháp A chứa 3 đĩa
        let pegA = Peg(name: "A", disks: disks)
        let pegB = Peg(name: "B")
        let pegC = Peg(name: "C")
        // Khởi chạy thuật toán di chuyển từ thap A qua tháp C
        moves = HanoiSolver().moveAllDisksFromPeg(fromPeg: pegA, toPeg: pegC, otherPeg: pegB)
        // Vẽ đĩa tương ứng với số đĩa được chọn
        self.tower.paintTower(disk_count: count)
        // add đĩa vào View
        self.view.addSubview(tower)
       
        // Khởi tạo đối tượng máy bay
        bird.frame = CGRect(x: self.tower.viewTempTowerA.frame.origin.x, y: self.tower.viewTempTowerA.frame.origin.y + 25 + CGFloat(5 - count)*25, width: self.tower.viewTempTowerA.frame.width, height: 50)
        bird.animationImages = [UIImage(named: "1.png")!,
        UIImage(named: "2.png")!,
        UIImage(named: "3.png")!,
        ]
        bird.animationRepeatCount = 0;
        bird.animationDuration = 0.1;
        self.view.addSubview(bird)
        bird.startAnimating()
        
    }
    
    // MARK:: Methods - PlaySong
    func playSong()
    {
        let filePath = Bundle.main.path(forResource: "halicoper", ofType: ".wav")
        let url = URL(fileURLWithPath: filePath!)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
   
    // MARK:: Methods - Animation
    func animation(){
        
        let move = moves[i]
        print("")
        print(move.description)
        UIView.setAnimationsEnabled(true)
        
        
        UIView.animate(withDuration: 1, animations: {
            if move.fromPeg.name == "A"{
                
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0)
                self.countA -= 1
                self.moveUpHelicoper(obj: self.bird, peg: 0)
                
            }
            else if move.fromPeg.name == "B"{
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1)
                self.countB -= 1
                self.moveUpHelicoper(obj: self.bird, peg: 1)
                print("Move Up \(move.description)")

            }
                
            else if move.fromPeg.name == "C"{
                print(move.fromPeg.diskCount - 1)
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2)
                self.countC -= 1
                self.moveUpHelicoper(obj: self.bird, peg: 2)
                
            }
            
        } , completion: { (true) in
            UIView.animate(withDuration: 1, animations: {
                let index = self.i + 1
                let index2 = self.i - 1
                if index < self.moves.count{
                    if (move.fromPeg.name == "B" && move.toPeg.name == "A" && index2 > 0 && self.moves[index2].toPeg.name == "C"){
                    
                    }
                    else if (move.fromPeg.name == "B" && move.toPeg.name == "C" && index2 > 0 && self.moves[index2].toPeg.name == "A"){
                        
                    }
                    else {
                        self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
                    }
                }
                else{
                    self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
                }
            }, completion: { (_) in
            UIView.animate(withDuration: 1, animations: {
                
                if move.toPeg.name == "A"{
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0)
                    self.moveCrossHelicoper(obj: self.bird, peg: 0)
                }
                else if move.toPeg.name == "B"{
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1)
                    self.moveCrossHelicoper(obj: self.bird, peg: 1)
                }
                else  if move.toPeg.name == "C"{
                    print(move.fromPeg.diskCount - 1)
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2)
                    self.moveCrossHelicoper(obj: self.bird, peg: 2)
                }
                
            }, completion: { (true) in
                UIView.animate(withDuration: 1, animations: {
                    if move.toPeg.name == "A"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0, count: self.countA)
                        self.countA += 1
                        self.moveDownHelicoper(obj: self.bird, peg: 0, count: self.countA)
                    }
                    else if move.toPeg.name == "B"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1, count: self.countB)
                        self.countB += 1
                        self.moveDownHelicoper(obj: self.bird, peg: 1, count: self.countB)
                    }
                    else if move.toPeg.name == "C"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2, count: self.countC)
                        self.countC += 1
                        self.moveDownHelicoper(obj: self.bird, peg: 2, count: self.countC)
                    }
                    
                }, completion: { (_) in
                    UIView.animate(withDuration: 1, animations: {
                        if move.toPeg.name == "A"{
                            
                            self.moveUpHelicoper(obj: self.bird, peg: 0)
                            
                        }
                        else if move.toPeg.name == "B"{

                            self.moveUpHelicoper(obj: self.bird, peg: 1)
                            
                        }
                            
                        else if move.toPeg.name == "C"{
                            
                            self.moveUpHelicoper(obj: self.bird, peg: 2)
                            
                        }
                    }, completion: { (_) in
                        UIView.animate(withDuration: 1, animations: {
                            let index = self.i + 1
                            if index < self.moves.count {

                                if (move.fromPeg.name == "A" && move.toPeg.name == "B" && self.moves[index].fromPeg.name == "C")
                                {
                                    print("11")
                                    
                                }
                                else if (move.fromPeg.name == "C" && move.toPeg.name == "B" && self.moves[index].fromPeg.name == "A"){
                                    
                                    print("33")
                                }
                                else {
                                    self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
                                }

                                
                            }
                            else{
                                self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
                            }
                        }, completion: { (_) in
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            let index = self.i + 1
                            if index < self.moves.count{
                            let temp = self.moves[index]
                            if temp.fromPeg.name == "A"{

                                self.moveCrossHelicoper(obj: self.bird, peg: 0)
                            }
                            else if temp.fromPeg.name == "B"{

                                self.moveCrossHelicoper(obj: self.bird, peg: 1)
                            }
                            else  if temp.fromPeg.name == "C"{
                                self.moveCrossHelicoper(obj: self.bird, peg: 2)
                                }
                            }

                        }, completion: { (_) in
                            UIView.animate(withDuration: 1, animations: {
                                let index = self.i + 1
                                if index < self.moves.count{
                                let temp = self.moves[index]
                                if temp.fromPeg.name == "A"{
                                    self.moveDownHelicoper(obj: self.bird, peg: 0, count: self.countA)
                                }
                                else if temp.fromPeg.name == "B"{
                                    
                                    self.moveDownHelicoper(obj: self.bird, peg: 1, count: self.countB)
                                }
                                else if temp.fromPeg.name == "C"{

                                    self.moveDownHelicoper(obj: self.bird, peg: 2, count: self.countC)
                                }
                            }
                            }, completion: { (_) in
                                self.dismiss(animated: true, completion: nil)
                                self.i = self.i + 1
                                if self.i == self.moves.count{
                                    return
                                }
                                let disk = move.fromPeg.removeTopDisk()
                                move.toPeg.addDisk(disk: disk)
                                self.animation()
                            })
                        })
                    })
                    })
                })
                })
            })
        })
    }
    
        //MARK:: Methods - MoveUp
    func moveUp(disk: UIView , peg: Int){
        if peg == 0{
                disk.center = self.tower.viewTempTowerA.center
        }
        else if peg == 1 {
                disk.center = self.tower.viewTempTowerB.center
        }
        else if peg == 2{
                disk.center = self.tower.viewTempTowerC.center
        }
    }
    func moveUpHelicoper(obj: UIImageView , peg: Int ){
        if peg == 0{
            obj.center = self.tower.viewTempTowerABird.center
        }
        else if peg == 1{
            obj.center = self.tower.viewTempTowerBBird.center
        }
        else if peg == 2{
            obj.center = self.tower.viewTempTowerCBird.center
        }
    }
  
        //MARK:: Methods - MoveCross
    func moveCross(disk: UIView , peg : Int){
        if peg == 0{
            disk.center = self.tower.viewTempTowerA.center
        }
        else if peg == 1{
            disk.center = self.tower.viewTempTowerB.center
        }
        else if peg == 2{
            disk.center = self.tower.viewTempTowerC.center
        }
    }
    func moveCrossHelicoper(obj: UIImageView , peg: Int){
        if peg == 0{
            obj.center = self.tower.viewTempTowerABird.center
        }
        else if peg == 1{
            obj.center = self.tower.viewTempTowerBBird.center
        }
        else if peg == 2{
            obj.center = self.tower.viewTempTowerCBird.center
        }
    }
    
        //MARK:: Methods - MoveDown
    func moveDown(disk: UIView, peg: Int , count: Int){
        if peg == 0{
            if count == 0 {
                disk.center = self.tower.diskTempTowerA_Array[0].center
            }
            else if count == 1 {
                disk.center = self.tower.diskTempTowerA_Array[1].center
            }
            else if count == 2{
                disk.center = self.tower.diskTempTowerA_Array[2].center
            }
            else if count == 3{
                disk.center = self.tower.diskTempTowerA_Array[3].center
            }
            else if count == 4{
                disk.center = self.tower.diskTempTowerA_Array[4].center
            }
            
        }
        else if peg == 1{
            if count == 0 {
                disk.center = self.tower.diskTempTowerB_Array[0].center
            }
            else if count == 1{
                disk.center = self.tower.diskTempTowerB_Array[1].center
            }
            else if count == 2{
                disk.center = self.tower.diskTempTowerB_Array[2].center
            }
            else if count == 3{
                disk.center = self.tower.diskTempTowerB_Array[3].center
            }
            else if count == 4{
                disk.center = self.tower.diskTempTowerB_Array[4].center
            }
        }
        else if peg == 2{
            if count == 0 {
                disk.center = self.tower.diskTempTowerC_Array[0].center
            }
            else if count == 1{
                disk.center = self.tower.diskTempTowerC_Array[1].center
            }
            else if count == 2{
                disk.center = self.tower.diskTempTowerC_Array[2].center
            }
            else if count == 3{
                disk.center = self.tower.diskTempTowerC_Array[3].center
            }
            else if count == 4{
                disk.center = self.tower.diskTempTowerC_Array[4].center
            }
        }
    
    }
    func moveDownHelicoper(obj : UIImageView, peg: Int, count: Int){
        if peg == 0{
            if count == 1 {
                obj.center = self.tower.diskTempTowerA_Array[1].center
            }
            else if count == 2 {
                obj.center = self.tower.diskTempTowerA_Array[2].center
            }
            else if count == 3{
                obj.center = self.tower.diskTempTowerA_Array[3].center
            }
            else if count == 4{
                obj.center = self.tower.diskTempTowerA_Array[4].center
            }
            else if count == 5{
                obj.center = self.tower.diskTempTowerA_Array[4].center
            }
        }
        else if peg == 1{
            if count == 1 {
                obj.center = self.tower.diskTempTowerB_Array[1].center
            }
            else if count == 2{
                obj.center = self.tower.diskTempTowerB_Array[2].center
            }
            else if count == 3{
                obj.center = self.tower.diskTempTowerB_Array[3].center
            }
            else if count == 4{
                obj.center = self.tower.diskTempTowerB_Array[4].center
            }
            else if count == 5{
                obj.center = self.tower.diskTempTowerB_Array[4].center
            }
        }
        else if peg == 2{
            if count == 1 {
                obj.center = self.tower.diskTempTowerC_Array[1].center
            }
            else if count == 2{
                obj.center = self.tower.diskTempTowerC_Array[2].center
            }
            else if count == 3 {
                obj.center = self.tower.diskTempTowerC_Array[3].center
            }
            else if count == 4{
                obj.center = self.tower.diskTempTowerC_Array[4].center
            }
            else if count == 5{
                obj.center = self.tower.diskTempTowerC_Array[4].center
            }
        }

    }

}


