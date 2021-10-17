//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    let pokemons = PokemonGenerator.shared.getPokemonArray()

    @IBOutlet var collectionView: UICollectionView!
//    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Access
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        cell.backgroundColor = UIColor.blue
        
     
 
//        let url = pokemons[indexPath.row].imageUrl
//            do{
//                let data = try Data(contentsOf: url)
//                cell.imageView.image = UIImage(data: data)
//            }catch let err{
//                print("Error: \(err.localizedDescription)")
//            }
//        }
       
     
        let u = pokemons[indexPath.row].imageUrl

        if u != nil {
            cell.imageView.loadImge(u!)

        }
//

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 1
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
  
}

extension UIImageView {
    func loadImge(_ url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}


