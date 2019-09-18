//
//  SettingsController.swift
//  FlashcardMaker
//
//  Created by Derek Burrola on 9/18/19.
//  Copyright © 2019 Derek Burrola. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    
    @IBOutlet weak var colorThemeLabel: UILabel!
    @IBOutlet weak var secondLabelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func purpleID(_ sender: Any) {
        changePageColors(86.0,115.0,222.0, 1.0)
        changeTextColors(80,110,200,1)
    }
    
    @IBAction func redID(_ sender: Any) {
        changePageColors(255,59,48,1)
    }
    
    @IBAction func blueID(_ sender: Any) {
        changePageColors(47,132,246,1)
    }
    
    @IBAction func greenID(_ sender: Any) {
        changePageColors(104,191,98,1)
    }
    
    @IBAction func yellowID(_ sender: Any) {
        changePageColors(247,202,74,1)
    }
    
    /*
     Takes in an RGBA set of doubles and change the background of the views to the color passed in
     */
    func changePageColors(_ r: Double, _ g: Double, _ b: Double, _ a: Double){
        // For some reason all RGB colors need to be divided by 255 to work properly
        let color = UIColor(red: CGFloat(r/255), green: CGFloat(g/255),blue: CGFloat(b/255), alpha:CGFloat(a))
        
        view.backgroundColor = color
        
        
        MainPageViewController.init().view.backgroundColor = color
    }
    
    func changeTextColors(_ r: Double, _ g: Double, _ b: Double, _ a: Double){
        let textColor = UIColor(red: CGFloat(r/255), green: CGFloat((g/2)/255), blue: CGFloat((b/3)/255), alpha: CGFloat(a))
        
        colorThemeLabel.textColor = textColor
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "settingsToMain", sender: self)
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
