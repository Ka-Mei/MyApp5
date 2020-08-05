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
    private(set) var documentId: String!
    private(set) var latitude: Double!
    private(set) var longitude: Double!
    //オス=true メス=false
    private(set) var gender:Bool!
    
    init(userName:String, userId:String, address:String, name:String, information:String, photo_1: String, timeStamp: Date, documentId: String, gender: Bool,latitude:Double, longitude:Double ){
        self.userName = userName
        self.userId = userId
        self.address = address
        self.name = name
        self.information = information
        self.photo_1 = photo_1
        self.timeStamp = timeStamp
        self.documentId = documentId
        self.gender = gender
        self.latitude = latitude
        self.longitude = longitude
        
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
            let documentId = document.documentID
            let gender = document["gender"] as? Bool ?? true
            let latitude = document["latitude"] as? Double ?? 35.0
            let longitude = document["longitude"] as? Double ?? 135.0
            
            let new_animal = Animal(userName: userName, userId: userId, address: address, name: name, information: information, photo_1: photo_1, timeStamp: timestamp,documentId: documentId, gender: gender, latitude: latitude, longitude: longitude)
            animals.append(new_animal)
            
        }
        return animals
    }
    
}
