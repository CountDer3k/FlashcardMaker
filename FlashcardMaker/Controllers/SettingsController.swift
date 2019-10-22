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
    var lastCaller = String()
    var alertText = "Download probably failed"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets background color and text
        view.backgroundColor = currentColor
        colorThemeLabel.textColor = currentTextColor
        themeLabel.textColor = currentTextColor
        themeLabel.text = "Theme: " + currentTheme
    }
    
    //---------------------
    // Color Setters
    //---------------------
    
    @IBAction func whiteID(_ sender: UIButton) {
        changePageColors(sender.backgroundColor!)
        changeTextColors(1,1,1,1)
        changeLabels(214, 214, 214, 1)
        changeButtons(214, 214, 214, 1)
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
    // Color Functions
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
        currentTheme = theme
    }
    
    //-----------------------
    //Download File Functions
    //-----------------------
    
    func overrideDownloadedFile(_ backup: Bool){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("questions.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            print("about to compare")
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
                // if it exists, then change the name to a backup
                changeFileName(backup)
                // Download new file
                downloadQuestionsFile()
                //Delete backup file
                deleteBackupFile()
            } else {
                print("FILE NOT AVAILABLE")
                // Continue the download
                downloadQuestionsFile()
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
        }
    }

    
    
    /* Function to download the questions file from my google drive
       if file exists, then change the name, until the new one is downloaded, then delete the old one
       If the download fails, rename the old file to one can be used
    */
    func downloadQuestionsFile(){
        // Create destination URL    
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("questions.txt")
        var alertString = ""
        //Create URL to the source file you want to download
        let fileURL = URL(string: "https://drive.google.com/uc?id=1oS654WdhWcvo4hJWdBrln7kpmVaC8XUu&export=download")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("DOWNLOAD_CODE: " + String(statusCode))
                    alertString = "Successfully updated questions"
                    self.showAlert(alertString, "Download Complete", "Got it!")
                    // Moves the file to the documents section
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    }
                    catch (let writeError) {
                        alertString = "Something went wrong. Text Der3k for file"
                        print("Error creating a file D3 \(destinationFileUrl) : \(writeError)")
                    }
                }
            }
            else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                // restore backup file
                changeFileName(true)
            }
        }
        //TODO:- This doesn't work. Need to check how to keep the string outside of its little inner self circle thing
        alertText = alertString
        task.resume()
    }


    
  
    
    @IBAction func EdgeSwipe(_ sender: Any) {
        performSegue(withIdentifier: "settingsToMain", sender: self)
    }
    
    /* Shows an alert that will print out if the file was properly downloaded or if an error occured*/
    func showAlert(_ whatToSay : String, _ title: String, _ buttonTitle: String) {
        let alertController = UIAlertController(title: title, message:
            whatToSay, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func secretFunction(_ sender: Any) {
        showAlert("\nNice find ;) \nCount Der3k \n2019 \nI love Patricia!", "Easter Egg", ";)")
    }
    
    
    
    //---------------------
    //Button functions
    //---------------------
    @IBAction func downloadQuestions(_ sender: Any) {
        //downloadQuestionsFile()
        overrideDownloadedFile(false)
        showAlert(alertText, "Download Complete", "Got it!")
        hasTextFile = 0
    }
    
    //---------------------
    // Segues
    //---------------------
    @IBAction func goBack(_ sender: Any) {
        if lastCaller == "Main"{
            performSegue(withIdentifier: "settingsToMain", sender: self)
        }
        if lastCaller == "Questions"{
            performSegue(withIdentifier: "settingsToQuestions", sender: self)
        }
    }
}
