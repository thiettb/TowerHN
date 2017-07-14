//
//  Tower.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class Tower: UIView {
    
    //Mark: Property
    var tower_name : String!
    let disk_width_init = (UIScreen.main.bounds.width - CGFloat(4*10))/3
    let disk_height_init = CGFloat(30)
    let disk_coordinate_Y = (UIScreen.main.bounds.height - CGFloat(30) - 30)
    let disk_coordinate_X = CGFloat(10)
    
    //Mark: Function
    func paintTower(disk_count: Int){
        for i in 0...(disk_count - 1){
            var tempView = UIView()
            tempView = UIView(frame: CGRect(x: self.disk_coordinate_X + CGFloat(i)*disk_width_init/10, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempView.backgroundColor = UIColor.red
            self.addSubview(tempView)
            
            var tempHiddenView = UIView()
            tempHiddenView = UIView(frame: CGRect(x: 2*self.disk_coordinate_X + CGFloat(i)*disk_width_init/10 + disk_width_init, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempHiddenView.backgroundColor = UIColor.black
            self.addSubview(tempHiddenView)
            
            var tempHiddenView2 = UIView()
            tempHiddenView2 = UIView(frame: CGRect(x: 3*self.disk_coordinate_X + CGFloat(i)*disk_width_init/10 + disk_width_init*2, y: self.disk_coordinate_Y - CGFloat(i)*disk_height_init, width: disk_width_init - CGFloat(i)*2*disk_width_init/10, height: disk_height_init))
            tempHiddenView2.backgroundColor = UIColor.black
            self.addSubview(tempHiddenView2)
            
            var subview = UIView()
            subview = UIView(frame: CGRect(x: 0, y: disk_coordinate_Y + CGFloat(30), width: UIScreen.main.bounds.width, height: 60))
            subview.backgroundColor = UIColor.green
            self.addSubview(subview)
        }
    }

}
