//
//  Disk.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class DiskView:UIView {

    //Mark:: Property
    static let disk_weight = (UIScreen.main.bounds.width - CGFloat(4*10))/3
   
    //Mark:: Function
    func move(from: UIView,to: UIView,temp1: UIView, temp2: UIView){
        UIView.animate(withDuration: 2.0, animations: {
            from.center = temp1.center
        }, completion: {(finished) in            
            UIView.animate(withDuration: 2.0, animations: {
            from.center = temp2.center
        }, completion: { (finished) in UIView.animate(withDuration: 2.0, animations: {
            from.center = to.center
        }, completion: nil)})})
    }
}

class Disk {
    var diameter: Int
    
    init(_ diameter: Int) {
        self.diameter = diameter
    }
}

struct Move{
    var fromPeg: Peg
    var toPeg: Peg
    
    var description: String {
        return "\(fromPeg.name) -> \(toPeg.name)"
    }
    
    init(fromPeg: Peg, toPeg: Peg) {
        self.fromPeg = fromPeg
        self.toPeg = toPeg
    }
    func getTopDisk() -> Disk{
        let disk = fromPeg.getTopDisk()
        return disk
    }
    
    func execute() -> Disk {
        let disk = fromPeg.removeTopDisk()
        toPeg.addDisk(disk: disk)
        return disk
    }
    func movedisk(from: Peg,to: Peg){
        let diskRun = Tower()
        var viewAnimation = UIView()
        let diameter = from.getTopDisk().diameter
        if diameter == 1{
            viewAnimation = diskRun.diskArray[4]
            if from.name.contains("A") && to.name.contains("C") && to.diskCount == 0{
                viewAnimation.animatingQueue.enqueue(AnimateItem(item: diskRun.viewTempTowerA, time: 2))
                viewAnimation.animatingQueue.enqueue(AnimateItem(item: diskRun.viewTempTowerC, time: 2))
                viewAnimation.animatingQueue.enqueue(AnimateItem(item: diskRun.diskTempTowerC_Array[0], time: 2))
                viewAnimation.animateCustom()
            }
        }
        
        
    
    }
    
}

struct HanoiSolver {
    
    func moveAllDisksFromPeg(fromPeg: Peg, toPeg: Peg, otherPeg: Peg) -> [Move] {
        return moveNumberOfDisks(count: fromPeg.diskCount,
                                 fromPeg:  fromPeg,
                                 toPeg:    toPeg,
                                 otherPeg: otherPeg)
    }
    
    func moveNumberOfDisks(count: Int, fromPeg: Peg, toPeg: Peg, otherPeg: Peg) -> [Move] {
        var moves = Array<Move>()
        if count == 1{
            moves.append(Move(fromPeg: fromPeg, toPeg: toPeg))
        }
        else
        {
            moves += moveNumberOfDisks(count: count - 1,
                                       fromPeg:  fromPeg,
                                       toPeg:    otherPeg,
                                       otherPeg: toPeg)
            
            moves += moveNumberOfDisks(count: 1, fromPeg: fromPeg, toPeg: toPeg, otherPeg: otherPeg)
            moves += moveNumberOfDisks(count: count - 1,
                                       fromPeg:  otherPeg,
                                       toPeg:    toPeg,
                                       otherPeg: fromPeg)
        }
        return moves;
    }
}



