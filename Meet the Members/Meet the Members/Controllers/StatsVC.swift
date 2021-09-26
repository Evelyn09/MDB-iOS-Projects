//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
//    let dataExample: String
    let correctStreak: Int
    let lastThreeResult: [String]
    
    init(correct: Int, three: [String]) {
        self.correctStreak = correct
        self.lastThreeResult = three
        // Delegate rest of the initialization to super class
        // designated initializer.
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints
    
    let showStreak: UILabel = {
        
        let sh = UILabel()
        sh.translatesAutoresizingMaskIntoConstraints = false
        return sh
        
    }()
    
    let showLastThree: UILabel = {
        
        let lt = UILabel()
        lt.translatesAutoresizingMaskIntoConstraints = false
        return lt
    }()
    
    let backButton: UIButton = {
        
        let back = UIButton()
        back.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        back.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        back.tintColor = .magenta
        back.translatesAutoresizingMaskIntoConstraints = false
        return back

    }()
    
    
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        showStreak.text = "Longest streak is: "+String(correctStreak)
        showStreak.textColor = .magenta
        showStreak.textAlignment = .center
        showStreak.font = .systemFont(ofSize: 40, weight: .medium)
        showStreak.numberOfLines = 2
        
        var showText: String = "Last 3 Results: "
        
        for r in lastThreeResult{
            showText+=r+" "
        }
        
        showLastThree.text = showText
        showLastThree.textColor = .magenta
        showLastThree.textAlignment = .center
        showLastThree.font = .systemFont(ofSize: 40, weight: .medium)
        showLastThree.numberOfLines = 4
        
    
        view.addSubview(showStreak)
        view.addSubview(showLastThree)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            showStreak.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            showStreak.widthAnchor.constraint(equalTo: showStreak.heightAnchor),
            
            showStreak.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            
            showStreak.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            
            
            showLastThree.topAnchor.constraint(equalTo: showStreak.bottomAnchor, constant: 50),
            
            showLastThree.widthAnchor.constraint(equalTo: showLastThree.heightAnchor),
            
            showLastThree.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            
            showLastThree.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            backButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: -80),

            backButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: 50),
      
            
        ])
        
        backButton.addTarget(self, action: #selector(backToMain(_:)), for: .touchUpInside)

        // MARK: >> Your Code Here <<
        
   
    }
    
    @objc func backToMain(_ sender: UIButton){
    
//        present(vc, animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)

    }
    
    

}
