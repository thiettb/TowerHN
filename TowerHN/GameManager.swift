//
//  GameManager.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit
//struct Step{
//    var towerFrom : Peg
//    var towerTo: Peg
//    var
//}



class GameManager: UIViewController {
    
    //MARK:: Parametters - User
    var tower = Tower()
    var disk = DiskView()
    var dataCountSelect : [String] = ["3","4","5"]
    var dataCount = String()
    var moves = [Move]()
    var i = 0
    var countA = 3
    var countB = 0
    var countC = 0
    
    
    //MARK:: Parametter - UI
    var lblTitle = UILabel()
    var lblSelectCount_Disk = UILabel()
    var btnMove = UIButton()
    var textField = UITextField()
    let picker = UIPickerView()
    var bird = UIImageView()
    
    
    //MARK:: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadViewForRun()
        self.tower.paintTower(disk_count: 3)
        self.view.addSubview(tower)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let disks = [
//            Disk(5),
//            Disk(4),
            Disk(1),
            Disk(2),
            Disk(3)]
        let pegA = Peg(name: "A", disks: disks)
        let pegB = Peg(name: "B")
        let pegC = Peg(name: "C")
        

        
        
        print("Start:")
        print(pegA.description)
        print(pegB.description)
        print(pegC.description)
        print()
        
        // Create solver and generate the sequence of moves needed
        
        moves = HanoiSolver().moveAllDisksFromPeg(fromPeg: pegA, toPeg: pegC, otherPeg: pegB)

        
        // Apply the moves
        print("Number of moves: \(moves.count)")
        print("")

//        print("\nFinish:")
//        print(pegA.description)
//        print(pegB.description)
//        print(pegC.description)
        self.addBird()
        self.animation()
        
    }
   
    func animation(){
        
        let move = moves[i]
        print("")
        print(move.fromPeg.description)
        UIView.setAnimationsEnabled(true)
        
        
        UIView.animate(withDuration: 2.0, animations: {
            if move.fromPeg.name == "A"{
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0)
                self.countA -= 1
                

                
            }
            else if move.fromPeg.name == "B"{
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1)
                self.countB -= 1

            }
                
            else if move.fromPeg.name == "C"{
                print(move.fromPeg.diskCount - 1)
                self.moveUp(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2)
                self.countC -= 1
                
            }
            
        } , completion: { (true) in
            UIView.animate(withDuration: 2.0, animations: {
                
                if move.toPeg.name == "A"{
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0)
                }
                else if move.toPeg.name == "B"{
                    
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1)
                }
                else  if move.toPeg.name == "C"{
                    print(move.fromPeg.diskCount - 1)
                    self.moveCross(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2)
                }
                
            }, completion: { (true) in
                UIView.animate(withDuration: 2.0, animations: {
                    if move.toPeg.name == "A"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 0, count: self.countA)
                        self.countA += 1
                    }
                    else if move.toPeg.name == "B"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 1, count: self.countB)
                        self.countB += 1
                    }
                    else if move.toPeg.name == "C"{
                        
                        self.moveDown(disk: self.tower.diskArray[move.fromPeg.getTopDisk().diameter - 1], peg: 2, count: self.countC)
                        self.countC += 1
                    }
                    
                }, completion: { (_) in
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
//        print(move.execute().diameter)
    }
    
    // Di len Dia
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
    // Di len cho Chim
    func moveUpBird(peg: Int){
        
    }
    
    // Di ngang
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
    // Di xuong 
    func moveDown(disk: UIView, peg: Int , count: Int){
        if peg == 0{
            if count == 0 {
                disk.center = self.tower.diskTempTowerA_Array[0].center
            }
            else if count == 1 {
                disk.center = self.tower.diskTempTowerA_Array[1].center
            }
            else if peg == 2{
                disk.center = self.tower.diskTempTowerA_Array[2].center
            }
        }
        else if peg == 1{
            if count == 0 {
                disk.center = self.tower.diskTempTowerB_Array[0].center
            }
            else if count == 1{
                disk.center = self.tower.diskTempTowerB_Array[1].center
            }
            else if peg == 2{
                disk.center = self.tower.diskTempTowerB_Array[2].center
            }
        }
        else if peg == 2{
            if count == 0 {
                disk.center = self.tower.diskTempTowerC_Array[0].center
            }
            else if count == 1{
                disk.center = self.tower.diskTempTowerC_Array[1].center
            }
            else if peg == 2 {
                disk.center = self.tower.diskTempTowerC_Array[2].center
            }
        }
    
    }
    //MARK:: Methods - UI
    func loadViewForRun(){
       
//        btnMove = UIButton(frame: CGRect(x: 10, y: 100, width: 60, height: 60))
//        btnMove.backgroundColor = UIColor.blue
//        btnMove.setTitle("Move", for: .normal)
//        btnMove.addTarget(self, action: #selector(GameManager.runningButtonTapped), for: .touchDown)
//        self.view.addSubview(btnMove)
        
        self.lblTitle = UILabel(frame: CGRect(x: 10, y: 20, width: self.view.frame.width, height: 40))
        self.lblTitle.text = "Mô phỏng bài toán Tháp Hà Nội"
        self.lblTitle.textAlignment = .center
        self.lblTitle.font = UIFont(name: "Regular", size: 17)
        self.view.addSubview(lblTitle)
        
//        self.lblSelectCount_Disk = UILabel(frame: CGRect(x: 10, y: 60, width: self.view.frame.width/2, height: 40))
//        self.lblSelectCount_Disk.text = "Chọn số lượng đĩa"
//        self.lblSelectCount_Disk.textAlignment = .left
//        self.view.addSubview(lblSelectCount_Disk)
//        
//        picker.delegate = self
//        picker.dataSource = self
//        textField = UITextField(frame: CGRect(x: 10 + self.view.frame.width/2, y: 60, width: 40, height: 40))
//        textField.textAlignment = .center
//        textField.borderStyle = .line
//        self.textField.inputView = picker
//        self.view.addSubview(textField)
        
        
    }
    func runningButtonTapped(){
//        print("Button pressed")
//        var i = 0
//        print(moves[i].description)
//        print(moves[i].execute().diameter)
        
//        move
//        self.disk.move(from: self.tower.diskArray[4], to: self.tower.diskTempTowerB_Array[0], temp1: self.tower.viewTempTowerA, temp2: self.tower.viewTempTowerB)
    }
    // MARK:: Animation with Bird
    func addBird()
    {
        bird = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 68))
        bird.animationImages = [UIImage(named:"bird0.png")!,
                                UIImage(named:"bird1.png")!,
                                UIImage(named:"bird2.png")!,
                                UIImage(named:"bird3.png")!,
                                UIImage(named:"bird4.png")!,
                                UIImage(named:"bird5.png")!]
        bird.animationRepeatCount = 0;
        bird.animationDuration = 1;
        self.view.addSubview(bird)
        bird.startAnimating()
    }
    
    
    //MARK:: Methods - extension UIPickerViewDelegate, UIPickerViewDataSource
}
extension GameManager: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataCountSelect[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField.text = self.dataCountSelect[row]
        self.textField.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataCountSelect.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

