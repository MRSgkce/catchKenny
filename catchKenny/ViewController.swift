//
//  ViewController.swift
//  catchKenny
//
//  Created by Mürşide Gökçe on 4.03.2025.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var counter = 0
    var timer = Timer()
    var hidetimer = Timer()
    var kennyarray = [UIImageView]()
    var highscore = 0
    
    //views
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    
    @IBOutlet weak var scorelabel: UILabel!
    
    @IBOutlet weak var highscorelabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!

 
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scorelabel.text = "score: \(score)"
        
        //highscore check
        let stored = UserDefaults.standard.object(forKey: "highscore")
        
        if stored == nil {
            highscore = 0
            highscorelabel.text = "highscore: \(highscore)"
        }
        if let newscore = stored as? Int {
            highscore = newscore
            highscorelabel.text = "highscore: \(highscore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer2=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer3=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer4=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer5=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer6=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer7=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer8=UITapGestureRecognizer(target:self,action:#selector(tap1))
        let recognizer9=UITapGestureRecognizer(target:self,action:#selector(tap1))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyarray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        //timers
        
        counter = 10
        timelabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeri), userInfo: nil, repeats: true)
        hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidekenny), userInfo: nil, repeats: true)
        hidekenny()
    }
    
    @objc func hidekenny(){
        for kenny in kennyarray{
            kenny.isHidden = true
            
        }
        let random = Int(arc4random_uniform(UInt32(kennyarray.count-1)))
        kennyarray[random].isHidden = false
    }
    
    
  @objc func tap1(){
    score += 1
    scorelabel.text = "Score: \(score)"
        
    }
    
    @objc func timeri(){
        counter -= 1
        timelabel.text = " \(counter)"
        
        if counter == 0{
            timer.invalidate()//timer durdurmak için
            hidetimer.invalidate()
            
            for kenny in kennyarray{
                kenny.isHidden = true
                
            }
            
            //highscore
            if self.score > self.highscore{
                self.highscore = self.score
                highscorelabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "SÜRE BİTTİ", message: "TEKRAR OYNAMAK İSTER MİSİN", preferredStyle: .alert)
            let ok = UIAlertAction(title: "tamam", style: .cancel, handler: nil)
            let replay = UIAlertAction(title: "tekrar oyna", style: .default){
                (UIAlertAction) in
                self.score = 0
                self.scorelabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timelabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeri), userInfo: nil, repeats: true)
                self.hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidekenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(ok)
            alert.addAction(replay)
            self.present(alert, animated: true,completion : nil )
        }
        
    }
}

