//
//  Animal.swift
//  MyLoseApp5
//
//  Created by MacBook16 on 2020/07/28.
//  Copyright © 2020 kawamuramei. All rights reserved.
//

import Foundation
import Firebase

class Animal {
    
    private(set) var userName: String!
    private(set) var userId: String!
    private(set) var address: String!
    private(set) var name: String!
    private(set) var information: String!
    private(set) var photo_1: String!
    private(set) var timeStamp: Date!
    
    init(userName:String, userId:String, address:String, name:String, information:String, photo_1: String, timeStamp: Date){
        self.userName = userName
        self.userId = userId
        self.address = address
        self.name = name
        self.information = information
        self.photo_1 = photo_1
        self.timeStamp = timeStamp
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Animal]{
        var animals = [Animal]()
        guard let snap = snapshot else{ return animals }
        for document in snap.documents{
            //for Transaction
            let data = document.data()
            let userName = document[USERNAME] as? String ?? "Anyone"
            let userId = document[USER_ID] as? String ?? ""
            let address = document["address"] as? String ?? ""
            let name = document["name"] as? String ?? ""
            let information = document["information"] as? String ?? ""
            let photo_1 = document["photo_1"] as? String ?? ""
            let timestamp = document["timeStamp"] as? Date ?? Date()
            let new_animal = Animal(userName: userName, userId: userId, address: address, name: name, information: information, photo_1: photo_1, timeStamp: timestamp)
            animals.append(new_animal)
            
        }
        return animals
    }
    
}
