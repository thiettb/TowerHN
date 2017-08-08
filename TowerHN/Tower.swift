//
//  Tower.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class Tower: UIView {
    
    //MARK: Parametters
    
    var tower_name : String!
    let disk_width_init = (UIScreen.main.bounds.width - CGFloat(4*10))/3
    let disk_height_init = CGFloat(30)
    let disk_coordinate_Y = (UIScreen.main.bounds.height - CGFloat(30) - 30)
    let disk_coordinate_X = CGFloat(10)
    
    let viewTempTowerA = UIView(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - CGFloat(250), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    let viewTempTowerABird = UIView(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - CGFloat(310), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    let viewTempTowerB = UIView(frame: CGRect(x: 20 + (UIScreen.main.bounds.width - CGFloat(4*10))/3, y: UIScreen.main.bounds.height - CGFloat(250), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    let viewTempTowerBBird = UIView(frame: CGRect(x: 20 + (UIScreen.main.bounds.width - CGFloat(4*10))/3, y: UIScreen.main.bounds.height - CGFloat(310), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    let viewTempTowerC = UIView(frame: CGRect(x: 30 + 2*(UIScreen.main.bounds.width - CGFloat(4*10))/3, y: UIScreen.main.bounds.height - CGFloat(250), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    let viewTempTowerCBird = UIView(frame: CGRect(x: 30 + 2*(UIScreen.main.bounds.width - CGFloat(4*10))/3, y: UIScreen.main.bounds.height - CGFloat(310), width: (UIScreen.main.bounds.width - CGFloat(4*10))/3, height: 30))
    
    var diskArray = [UIView]()
    
    var diskTempTowerB_Array = [UIView]() 
    
    var diskTempTowerA_Array = [UIView]()
    
    var diskTempTowerC_Array = [UIView]()
    
    //MARK: Methods - UI
    func paintTower(disk_count: Int){
        
        for i in 0...(disk_count - 1){
            var tempView = UILabel()
            tempView = UILabel(frame: CGRect(x: self.disk_coordinate_X + CGFloat(i)*disk_width_init/10, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempView.backgroundColor = UIColor.red
            tempView.text = "\(3 - i)"
            tempView.textAlignment = .center
            tempView.layer.cornerRadius = tempView.frame.size.width / 15
            diskArray.append(tempView)
            self.addSubview(tempView)
            
            var tempHiddenView1 = UIView()
            tempHiddenView1 = UIView(frame: CGRect(x: self.disk_coordinate_X + CGFloat(i)*disk_width_init/10, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempHiddenView1.layer.cornerRadius = tempView.frame.size.width / 15
            diskTempTowerA_Array.append(tempHiddenView1)
            
            
            var tempHiddenView = UIView()
            tempHiddenView = UIView(frame: CGRect(x: 2*self.disk_coordinate_X + CGFloat(i)*disk_width_init/10 + disk_width_init, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempHiddenView.backgroundColor = UIColor.black
            diskTempTowerB_Array.append(tempHiddenView)
//            self.addSubview(tempHiddenView)
            
            var tempHiddenView2 = UIView()
            tempHiddenView2 = UIView(frame: CGRect(x: 3*self.disk_coordinate_X + CGFloat(i)*disk_width_init/10 + disk_width_init*2, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempHiddenView2.backgroundColor = UIColor.black
            diskTempTowerC_Array.append(tempHiddenView2)
//            self.addSubview(tempHiddenView2)
            
            var subview = UIView()
            subview = UIView(frame: CGRect(x: 0, y: disk_coordinate_Y + CGFloat(30), width: UIScreen.main.bounds.width, height: 60))
            subview.backgroundColor = UIColor.green
            self.addSubview(subview)

        }
    }
    var diskCount: Int { return diskArray.count }

}

class Peg{
    var name: String
    
    // Disks on peg, ordered from bottom to top
    var disks: [Disk]
    
    var diskCount: Int { return disks.count }
    
    var description: String {
        let diskNames = disks.map { $0.diameter }
        
        return "\(name): \(diskNames)"
    }
    
    init(name: String, disks: [Disk]) {
        self.name = name
        self.disks = disks
    }
    
    convenience init(name: String) {
        self.init(name: name, disks: Array<Disk>())
    }
    
    func addDisk(disk: Disk) {
        disks.append(disk)
    }
    
    func getTopDisk() -> Disk{
        return disks[disks.count - 1]
    }
    func removeTopDisk() -> Disk {
        return disks.removeLast()
    }
}


