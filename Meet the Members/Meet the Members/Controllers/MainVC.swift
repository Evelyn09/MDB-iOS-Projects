//
//  MainVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    var answerIndex = 0
    var seconds = 7
    var totScore = 0
    var longestStreak = 0
    var currentStreak = 0
    var result = String()
    
    
    var lastThree = [String]()
    var answer: String = ""

    
    let progressView: UIProgressView = {
        let pV = UIProgressView(progressViewStyle: .bar)
        pV.trackTintColor = .white
        pV.progressTintColor = .magenta
        pV.translatesAutoresizingMaskIntoConstraints = false
        return pV
    }()
    
    let pause: UIButton = {
        
        let p = UIButton()
        
        p.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        p.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        
        p.tintColor = .magenta
                
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    let score: UILabel = {
        
        let s = UILabel()
        
        s.text = "Score: 0"
        s.textColor = .magenta
        s.font = .systemFont(ofSize: 20, weight: .medium)
        
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    
    let stat: UIButton = {
        
        let st = UIButton()
        
        st.setImage(UIImage(systemName: "chart.bar"), for: .normal)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        st.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        
        st.tintColor = .magenta
        
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // MARK: STEP 7: UI Customization
    // Action Items:
    // - Customize your imageView and buttons.
    
    let imageView: UIImageView = {
        
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let buttons: [UIButton] = {
        return (0..<4).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
            
            button.backgroundColor = .magenta
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
        
    }()

    // MARK: STEP 10: Stats Button
    // Action Items:
    // - Follow the examples you've seen so far, create and
    // configure a UIButton for presenting the StatsVC. Only the
    // callback function `didTapStats(_:)` was written for you.
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        
        // Create a timer that calls timerCallback() every one second
      
   
        // MARK: STEP 6: Adding Subviews and Constraints
        // Action Items:
        // - Add imageViews and buttons to the root view.
        // - Create and activate the layout constraints.
        // - Run the App
        
        // Additional Information:
        // If you don't like the default presentation style,
        // you can change it to full screen too! However, in this
        // case you will have to find a way to manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: >> Your Code Here <<
        view.addSubview(imageView)
        
        for b in buttons{
            view.addSubview(b)
            b.layer.cornerRadius = 25.0
        }
        
        view.addSubview(pause)
        view.addSubview(score)
        view.addSubview(stat)
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            
       
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            
            imageView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            
            imageView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            
            buttons[0].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            
            buttons[0].trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            
            buttons[0].leadingAnchor.constraint(equalTo: buttons[0].trailingAnchor, constant: -150),
            
            buttons[0].bottomAnchor.constraint(equalTo: buttons[0].topAnchor, constant: 120),
            
            
            buttons[1].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            
            buttons[1].leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),

            buttons[1].trailingAnchor.constraint(equalTo: buttons[1].leadingAnchor, constant: 150),

            buttons[1].bottomAnchor.constraint(equalTo: buttons[1].topAnchor, constant: 120),

            
            buttons[2].topAnchor.constraint(equalTo: buttons[0].bottomAnchor, constant: 20),

            buttons[2].trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            
            buttons[2].leadingAnchor.constraint(equalTo: buttons[0].trailingAnchor, constant: -150),

            buttons[2].bottomAnchor.constraint(equalTo: buttons[2].topAnchor, constant: 120),

            
            buttons[3].topAnchor.constraint(equalTo: buttons[0].bottomAnchor, constant: 20),

            buttons[3].leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),

            buttons[3].trailingAnchor.constraint(equalTo: buttons[1].leadingAnchor, constant: 150),

            buttons[3].bottomAnchor.constraint(equalTo: buttons[3].topAnchor, constant: 120),
            
            
            pause.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),

            pause.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 25),

            pause.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -25),

            pause.bottomAnchor.constraint(equalTo: pause.topAnchor, constant: 50),
            
            
            
            stat.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),

            stat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            stat.leadingAnchor.constraint(equalTo: stat.trailingAnchor, constant:-80),

            stat.bottomAnchor.constraint(equalTo: stat.topAnchor, constant: 50),

            
            
            score.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            score.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            score.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),

            score.bottomAnchor.constraint(equalTo: score.topAnchor, constant: 50),
            
            
            progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            progressView.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: 5)
        
        ])
        
        
        getNextQuestion()
        
        // MARK: STEP 9: Bind Callbacks to the Buttons
        // Action Items:
        // - Bind the `didTapAnswer(_:)` function to the buttons.
        
        for b in buttons{
            b.addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        }
        stat.addTarget(self, action: #selector(paused(_:)), for: .touchUpInside)
        stat.addTarget(self, action: #selector(didTapStats(_:)), for: .touchUpInside)
        pause.addTarget(self, action: #selector(paused(_:)), for: .touchUpInside)
        
        // MARK: >> Your Code Here <<
        
        
        // MARK: STEP 10: Stats Button
        // See instructions above.
        
        // MARK: >> Your Code Here <<
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 13: Resume Game
        // Action Items:
        // - Reinstantiate timer when view appears

        // MARK: >> Your Code Here <<
        
        enableOrDisable(true)
        
        if timer?.isValid != true{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        }
    }
    
    func enableOrDisable(_ bo: Bool){
        for b in buttons{
            b.isEnabled = bo
        }
    }
    
    func getNextQuestion() {
        // MARK: STEP 5: Data Model
        // Action Items:
        // - Get a question instance from `QuestionProvider`
        // - Configure the imageView and buttons with information from
        //   the question instance
        
        // MARK: >> Your Code Here <<

        seconds = 7

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
        let question = QuestionProvider().nextQuestion()!
        
        var i = 0
        for name in question.choices {
            buttons[i].isEnabled = true
            buttons[i].setTitle(name, for: .normal)
            buttons[i].backgroundColor = .magenta
            buttons[i].setTitleColor(.white, for: .normal)
            buttons[i].titleLabel?.font = .systemFont(ofSize: 25)
            buttons[i].titleLabel?.lineBreakMode = .byWordWrapping
            
            if name == question.answer{
                answerIndex = i
            }
            
            i+=1
        }
        
        answer = question.answer
        imageView.image = question.image
        
    }
    
    // MARK: STEP 8: Buttons and Timer Callback
    // Action Items:
    // - Complete the callback function for the 4 buttons.
    // - Complete the callback function for the timer instance
    //
    // Additional Information:
    // Take some time to plan what should be in here.
    // The 4 buttons should share the same callback.
    //
    // Add instance properties and/or methods
    // to the class if necessary. You may need to come back
    // to this step later on.
    //
    // Hint:
    // - The timer will fire every one second.
    // - You can use `sender.tag` to identify which button is pressed.
    
    
    //figure out how to merge with timerCallback()
    
    
    @objc func timerCallback() {
        
        // MARK: >> Your Code Here <<
        
        progressView.setProgress(Float(seconds-2)*0.2, animated: true)
 
        if seconds == 2{
            
            progressView.setProgress(Float(seconds-2)*0.2, animated: true)
            
            if lastThree.count == 3{
                lastThree.remove(at: 0)
            }
            
            lastThree.append("Incorrect")
    
            enableOrDisable(false)
            buttons[answerIndex].backgroundColor = .systemGreen
            
        }
        else if seconds == 0{
            
            timer?.invalidate()
            progressView.setProgress(1, animated: true)
            getNextQuestion()
            return
        }
        seconds-=1
    }
    
    @objc func didTapAnswer(_ sender: UIButton) {
        
        if lastThree.count == 3{
            lastThree.remove(at: 0)
        }
        
        enableOrDisable(false)

        // MARK: >> Your Code Here <<
        if sender.title(for: .normal) == answer{
            
            result = "Correct"
            sender.backgroundColor = .systemGreen
            totScore+=1
            score.text = "Score: "+String(totScore)
            score.textColor = .magenta
            
            currentStreak+=1
            
            if currentStreak > longestStreak{
                longestStreak = currentStreak
            }
            
        } else {
            
            result = "Incorrect"
            currentStreak = 0
            sender.backgroundColor = .systemRed
            
            buttons[answerIndex].backgroundColor = .systemGreen
        }
        
        lastThree.append(result)
        
        timer?.invalidate()
        seconds = 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    @objc func paused(_ sender: UIButton) {
        
        if timer?.isValid != true{
            
            enableOrDisable(true)
       
            totScore = 0
            currentStreak = 0
            score.text = "Score: 0"
            
            progressView.setProgress(Float(seconds-2)*0.2, animated: false)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            
            pause.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)

        }
        else{
            
            progressView.setProgress(Float(seconds-2)*0.2, animated: true)
            enableOrDisable(false)

            timer?.invalidate()
            pause.setImage(UIImage(systemName: "restart.circle"), for: .normal)
            
        }
        
      
    }
    

    
    @objc func didTapStats(_ sender: UIButton) {
        
        pause.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)

        
        let vc = StatsVC(correct:longestStreak, three:lastThree)
        
        vc.modalPresentationStyle = .fullScreen
        
        // MARK: STEP 11: Going to StatsVC
        // When we are navigating between VCs (e.g MainVC -> StatsVC),
        // we often need a mechanism for transferring data
        // between view controllers. There are many ways to achieve
        // this (initializer, delegate, notification center,
        // combined, etc.). We will start with the easiest one today,
        // which is custom initializer.
        //
        // Action Items:
        // - Pause the game when stats button is tapped
        // - Read the example in StatsVC.swift, and replace it with
        //   your custom init for `StatsVC`
        // - Update the call site here on line 139
            
        present(vc, animated: true, completion: nil)
    }
}
