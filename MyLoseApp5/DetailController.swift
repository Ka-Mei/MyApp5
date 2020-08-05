//
//  DetailController.swift
//  MyLoseApp5
//
//  Created by 河村萌衣 on 2020/05/15.
//  Copyright © 2020 kawamuramei. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DetailController: UIViewController {

    var animal :Animal?
    
    private let db = Firestore.firestore()
        
    private let storage = Storage.storage()
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var memoText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let animal = animal else{ return }
        nameLabel.text = animal.name
        
        //firebaesからget
        let docRef = db.collection(ANIMAL_REF).document(animal.documentId)
        docRef.getDocument { (document, error) in
            if let error = error {
                print(error)
            }
            guard let document = document else{ return }
            
            self.nameLabel.text = document["name"] as? String
            self.addressLabel.text = document["address"] as? String
            if document["gender"] as? Bool == true{
                self.genderLabel.text = "オス"
            }else{
            self.genderLabel.text = "メス"
            }
            self.memoText.text = document["information"] as? String

        }
        
        //strageからimage get
        let strageRef = storage.reference(forURL: animal.photo_1)
        strageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else{ return }
            DispatchQueue.main.async {
                self.animalImage.image = UIImage(data: data)
            }
        }
        
    }
  
}
