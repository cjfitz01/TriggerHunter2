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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Room.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RoomCollectionViewCell
        cell.image.image = Room.all[indexPath.item].collectionViewImage
        cell.room = Room.all[indexPath.item]
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
        sendTrigger(for: cell.room)
    }
    
    func sendTrigger(for room: Room) {
        guard let trigger = room.randomTrigger else {
            let alert = UIAlertController(
                title: "Location not supported",
                message: "\"\(room.name)\" is not supported in this prototype.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        PushNotificationServerClient.spawnTrigger(trigger, in: room)
        
        let alert = UIAlertController(title: "\(trigger.name) sent to child's device", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

}
