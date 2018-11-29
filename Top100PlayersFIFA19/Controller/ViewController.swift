//
//  ViewController.swift
//  Top100PlayersFIFA19
//
//  Created by Omar Aldair Romero Pérez on 11/29/18.
//  Copyright © 2018 Omar Aldair Romero Pérez. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UICollectionViewController {
    
    let url = "https://www.easports.com/es/fifa/ratings/fifa-19-player-ratings-top-100"
    var factory : PlayerFactory!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        factory = PlayerFactory(url: url)
        
        // Notificación de que se agregaron nuevos objetos al array de PlayerModel
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItemsInCollectionView), name: NSNotification.Name(rawValue: "PlayerUpdate"), object: nil) // Agregar notification
        
    }
    
    
    // MARK: CollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.factory.playersArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        cell.namePlayer.text = self.factory.playersArray[indexPath.row].playerName
        cell.teamPlayer.text = self.factory.playersArray[indexPath.row].teamName
        cell.imagePlayer.downloadedFrom(link: self.factory.playersArray[indexPath.row].cardImageURL)
        
        
        return cell
    }
    
    // FUnción para recargar celdas de la collectionView
    @objc func reloadItemsInCollectionView(){
        self.collectionView.reloadData()
    }
    
    
    
    
    
    
    
  
    
    


}

