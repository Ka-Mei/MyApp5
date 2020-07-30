//
//  SearchListCell.swift
//  MyLoseApp5
//
//  Created by 河村萌衣 on 2020/07/24.
//  Copyright © 2020 kawamuramei. All rights reserved.
//

import UIKit
import FirebaseStorage

class SearchListCell: UITableViewCell {
    
    private let storage = Storage.storage()
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var dateText: UILabel!
    
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var statusImage: UIImageView!
    
    
    @IBAction func detailButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(animal: Animal) {
        //         optionsMenu.isHidden = true
        //         self.thought = thought
        //         self.delegate = delegate
        
        let gsReference = storage.reference(forURL: animal.photo_1)
        gsReference.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error)
                return
            }
            // Data for "images/island.jpg" is returned
            DispatchQueue.main.async {
                self.animalImage?.image = UIImage(data: data!)
            }
        }


        
        nameText.text = animal.name
        dateText.text = "2020/7/2"
        addressText.text = animal.address
        
        
        //         let formatter = DateFormatter()
        //         formatter.dateFormat = "MM月d日, hh:mm"
        //         let timestamp = formatter.string(from: thought.timestamp)
        //         timestampLbl.text = timestamp
        
        //         if thought.userId == Auth.auth().currentUser?.uid {
        //             optionsMenu.isHidden = false
        //             //set gestureRecognizer
        //             optionsMenu.isUserInteractionEnabled = true
        //             let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionTapped))
        //             optionsMenu.addGestureRecognizer(tap)
    }
}
    


