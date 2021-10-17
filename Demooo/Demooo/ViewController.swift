//
//  ViewController.swift
//  Demooo
//
//  Created by Evelyn Hu on 10/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    @IBAction func didTapButton(_ sender: Any) {
        
        let vc =
        
        self.performSeque(performSegue(withIdentifier: "toStatsVC", sender: [""]))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc. segue.destination as!
        
    }
    
}

extension ViewController: StatsVCDelegate{
    
    func statsVC(_ vc: StatsVC, didTapReset: Bool)
    print("OK")
}

