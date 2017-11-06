//
//  RoomSelectVC.swift
//  Trigger Hunter
//
//  Created by Conor Fitzpatrick on 10/5/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit

class RoomSelectVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var mainLabel: UILabel!
    let reuseIdentifier = "roomCell"
    var roomImages : [UIImage] = [UIImage(named:"Outside.png")!, UIImage(named:"Kitchen.png")!, UIImage(named:"Bedroom.png")!, UIImage(named:"Pet.png")!, UIImage(named:"Bathroom.png")!, UIImage(named:"Living_Room.png")!]
    var roomNames : [String] = ["Outside", "Kitchen", "Bedroom", "Pet", "Bathroom", "Living"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RoomCollectionViewCell
        cell.image.image = self.roomImages[indexPath.item]
        cell.room = self.roomNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RoomCollectionViewCell
        print(cell.room)
        //print(cell.room)
    }
    
    @IBAction func linkChildDevice(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
