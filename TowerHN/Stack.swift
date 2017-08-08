//
//  Stack.swift
//  TowerHN
//
//  Created by ThietTB on 7/30/17.
//  Copyright © 2017 bipbipdinang. All rights reserved.
//

import Foundation
class Stack {
    var stackArray = [String]()
    //create push function
    func push(stringToPush: String){
        self.stackArray.append(stringToPush)
    }
    //create pop function
    func pop() -> String? {
        if self.stackArray.last != nil {
            let stringToReturn = self.stackArray.last
            self.stackArray.removeLast()
            return stringToReturn!
        } else {
            return nil
        }
    }
}
