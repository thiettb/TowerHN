//
//  GameManager.swift
//  TowerHN
//
//  Created by ThietTB on 7/14/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import UIKit

class GameManager: UIViewController {
    //Mark:: Property
    var tower = Tower()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tower.paintTower(disk_count: 4)
        self.view.addSubview(tower)
        self.addButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:: Function
    func addButton(){
        var btnMove = UIButton()
        btnMove = UIButton(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        btnMove.backgroundColor = UIColor.blue
        btnMove.setTitle("Move", for: .normal)
        self.view.addSubview(btnMove)
    }

}
