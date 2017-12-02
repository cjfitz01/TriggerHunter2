//
//  RoomSelectVC.swift
//  Trigger Hunter
//
//  Created by Conor Fitzpatrick on 10/5/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit

class RoomSelectVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainLabel: UILabel!
    let reuseIdentifier = "roomCell"
    var roomImages : [UIImage] = [UIImage(named:"Outside.png")!, UIImage(named:"Kitchen.png")!, UIImage(named:"Bedroom.png")!, UIImage(named:"Pet.png")!, UIImage(named:"Bathroom.png")!, UIImage(named:"Living_Room.png")!]
    var roomNames : [String] = ["Outside", "Kitchen", "Bedroom", "Pet", "Bathroom", "Living"]
    
    enum Trigger: Int {
        case pollen = 1, coldWeather, smoke, cockroach, dustMite, mold, petDander, cleaningProduct
    }
    
    var currTrigger : Trigger!
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let cell = collectionView.cellForItem(at: indexPath) as! RoomCollectionViewCell
        //let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width * 0.47 , height: width * 0.47)
        //let imageSize = model.images[indexPath.row].size
        //return imageSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RoomCollectionViewCell

        if (cell.room == "Outside") {
            let randomNum = arc4random_uniform(3)+1
            currTrigger = Trigger(rawValue: Int(randomNum))
            
        } else if (cell.room == "Kitchen") {
            currTrigger = Trigger(rawValue: 4)
            
        } else if (cell.room == "Bedroom") {
            let randomNum = arc4random_uniform(2)+5
            currTrigger = Trigger(rawValue: Int(randomNum))

        } else if (cell.room == "Pet") {
            currTrigger = Trigger(rawValue:7)
            
        } else if (cell.room == "Bathroom") {
            currTrigger = Trigger(rawValue: 8)
            
        } else if (cell.room == "Living") {
            let randomNum = arc4random_uniform(2)+5
            currTrigger = Trigger(rawValue: Int(randomNum))
            
        }
        sendTrigger(trigger: currTrigger)
    }
    
    func sendTrigger(trigger:Trigger) {
        var triggerString:String!
        //make triggerString
        switch trigger {
        case .pollen:
            triggerString = "Pollen"
        case .coldWeather:
            triggerString = "Cold Weather"
        case .smoke:
            triggerString = "Smoke"
        case .cockroach:
            triggerString = "Cockroach"
        case .dustMite:
            triggerString = "Dust Mite"
        case .mold:
            triggerString = "Mold"
        case .petDander:
            triggerString = "Pet Dander"
        case .cleaningProduct:
            triggerString = "Smell from Cleaning Product"
        }
        let alert = UIAlertController(title: "Trigger Sent", message: "The following trigger has been sent to your child's device: \n \n \(triggerString!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            //NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func linkChildDevice(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    */

}
