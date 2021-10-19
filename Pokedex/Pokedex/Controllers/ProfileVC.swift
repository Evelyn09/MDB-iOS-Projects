//
//  ProfileVC.swift
//  Pokedex
//
//  Created by Evelyn Hu on 10/18/21.
//

import UIKit

class ProfileVC: UIViewController {
    
//    var pokemon = Pokemon(from: Decoder)
    
    @IBOutlet weak var poPic: UIImageView!
    @IBOutlet weak var lbl: UILabel!
//    var word: String?
    var po: Pokemon?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        
        lbl.text = "Name: "+po!.name+"\n"+"ID: "+String(po!.id)+"\n"+"Attack: "+String(po!.attack)+"\n"+"Defense: "+String(po!.defense)+"\n"+"Health: "+String(po!.health)+"\n"+"Special Attack: "+String(po!.specialAttack)+"\n"+"Special Defense: "+String(po!.specialDefense)+"\n"+"Speed: "+String(po!.speed)+"\n"+"Total: "+String(po!.total)+"\n"
        
       
        
    
        
        let url = po?.imageUrl

        if url != nil {
            poPic.loadImge(url!)
        }
//        view.addSubview(lbl)

        // Do any additional setup after loading the view.
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

