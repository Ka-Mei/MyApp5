//
//  SearchListController.swift
//  MyLoseApp5
//
//  Created by 河村萌衣 on 2020/05/15.
//  Copyright © 2020 kawamuramei. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SearchListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var animals = [Animal]()
    @IBOutlet weak var tableView: UITableView!
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get data
        db.collection(ANIMAL_REF).getDocuments {[unowned self] (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.animals = Animal.parseData(snapshot: snapshot)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let animal = animals[indexPath.row]
      performSegue(withIdentifier: "toDetail", sender: animal)
  }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchListCell
        cell.configureCell(animal: animals[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }


}
