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
    @IBOutlet weak var themeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets background color and text
        view.backgroundColor = currentColor
    }
    
    //---------------------
    // Colors
    //---------------------
    
    @IBAction func whiteID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(1,1,1,1)
        changeLabels(214, 214, 214, 1)
        changeButtons(88,86,214,1)
        changeThemeText("Marble")
        
    }
    
    @IBAction func blackID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(255, 163, 48, 1)
        changeLabels(68, 68, 68, 1)
        changeButtons(255, 163, 48, 1)
        changeThemeText("Dark Mode")
    }
    
    @IBAction func blueID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(255, 163, 48, 1)
        changeLabels(0,150,255,1)
        changeButtons(255, 163, 48, 1)
        changeThemeText("Blue Sky")
    }
    
    @IBAction func orangeID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(0, 0, 0, 1)
        changeLabels(230, 144, 77, 1)
        changeButtons(170, 170, 170, 1)
        changeThemeText("Orange Juice")
    }
    
    @IBAction func purpleID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(255, 163, 48, 1)
        changeLabels(79, 76, 218, 1)
        changeButtons(164, 248, 255, 1)
        changeThemeText("Magenta")
    }
    
    
    //---------------------
    //Non-Button functions
    //---------------------
    
    func changePageColors(_ c: UIColor){
        view.backgroundColor = c
        currentColor = c
    }
    
    /* Takes in an RGBA set of doubles and change the background of the views to the color passed in */
    func changePageColors(_ r: Double, _ g: Double, _ b: Double, _ a: Double){
        let color = convertColors(r, g, b, a)
        view.backgroundColor = color
        currentColor = color
    }
    /* Takes in an RGBA set of doubles and change the text color of the views to the color passed in */
    func changeTextColors(_ r: Double, _ g: Double, _ b: Double, _ a: Double){
        let textColor = convertColors(r, g, b, a)
        colorThemeLabel.textColor = textColor
        themeLabel.textColor = textColor
        currentTextColor = textColor
    }
    /* Takes in an RGBA set of doubles and change the label color of the views to the color passed in */
    func changeLabels(_ r:Double, _ g:Double, _ b: Double, _ a: Double){
        let labelColor = convertColors(r, g, b, a)
        currentLabelColor = labelColor
    }
    /* Takes in an RGBA set of doubles and change the button color of the views to the color passed in */
    func changeButtons(_ r:Double, _ g:Double, _ b: Double, _ a: Double){
        let buttonColor = convertColors(r, g, b, a)
        currentButtonColor = buttonColor
    }
    /* Takes in an RGBA set of doubles and changes the text label text to the text passed in */
    func changeThemeText(_ theme: String){
        themeLabel.text = "Theme: " + theme
    }
    
    //---------------------
    // Segues
    //---------------------
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "settingsToMain", sender: self)
    }
    
    
}
