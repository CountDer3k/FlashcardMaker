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
        currentTheme = theme
    }
    
    //-----------------------
    //Download File Functions
    //-----------------------
    
    /* Function to download the questions file from my google drive*/
    func downloadQuestionsFile(){
            // Create destination URL
        
            // if file exists, then change the name, until the new one is downloaded, then delete the old one
            // If the download fails, rename the old file to one can be used
            
            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
            let destinationFileUrl = documentsUrl.appendingPathComponent("questions.txt")
               
            //Create URL to the source file you want to download
            let fileURL = URL(string: "https://drive.google.com/uc?id=1oS654WdhWcvo4hJWdBrln7kpmVaC8XUu&export=download")

            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = URLRequest(url:fileURL!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        self.showAlert("Successfully updated questions")
                    print("Successfully downloaded. Status code: \(statusCode)")
                    }
                       
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    } catch (let writeError) {
                    self.showAlert("Something went wrong. Text Der3k for file")
                        print("Error creating a file D3 \(destinationFileUrl) : \(writeError)")
                    }
                }
                else {
                    print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
                }
            }
            task.resume()
        readFile()
        self.showAlert("Successfully updated questions")
        hasTextFile = 0
    }

    /* Function to read a "questions.txt" file from the documents directory.
     Currently still needs to be able to read line by line & then export each line
     over to the modules array to be able to use the questions in the text file as questions
     on the actual program*/
    func readFile(){
        print("Begin reading")
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent("questions").appendingPathExtension("txt")
        do {
            // Read the file contents and saves it to a giant separated string
            let readString = try String(contentsOf: fileURL, encoding: .utf8)
            let myStrings = readString.components(separatedBy: .newlines)
            
            getQuestions(myStrings)
        }
        catch let error as NSError {
            //print("big chuck of error codes")
            //print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
    }
    
    func getQuestions(_ s : [String]){
        // Clears the questionList Array
        questionTitleList.removeAll()
        questionsListArray.removeAll()
        answersListArray.removeAll()
        var isAnswer = false
        var qArray = [String]()
        var aArray = [String]()
        
        // iterates through every items in s (the file whose contents were read)
        for i in s {
            // Takes the first 2 letters and checks for the special symbols that define its a title '##'
            var index = i.index(i.startIndex, offsetBy: 2)
            var mySubstring = i[..<index]
            var lineString = i[..<index]
            
            if mySubstring == "##"{
                // Grabs the whole line
                index = i.index(i.startIndex, offsetBy: i.count)
                mySubstring = i[..<index]
                // Drops the first two characters of the line (ie. '##')
                mySubstring = mySubstring.dropFirst().dropFirst()
                
                // Add each item to the global questions list array
                // the +"" is to convert a subsequence to a string
                questionTitleList.append(mySubstring+"")
            }
            else if(mySubstring == "^^"){
                // Stop the loop. Its all done
                return;
            }
            else if (mySubstring == "::"){
                // End of Answers. New list can start after this
                // Add questions array to arraylist
                questionsListArray.append(qArray)
                // add answers array to arralist
                answersListArray.append(aArray)
                // clear both array
                qArray.removeAll()
                aArray.removeAll()
                isAnswer = false
            }
            else if (mySubstring == "//"){
                // End of Questions
                isAnswer = true
            }
            else{
                index = i.index(i.startIndex, offsetBy: i.count)
                lineString = i[..<index]
                if(isAnswer){
                    // Add strings to answers Array
                    aArray.append(lineString+"")
                }
                else{
                    // Add string to questions array
                    qArray.append(lineString+"")
 
                }
            }
        }
        
    }
    
    
    /* Shows an alert that will print out if the file was properly downloaded or if an error occured*/
    func showAlert(_ whatToSay : String) {
        let alertController = UIAlertController(title: "Download Complete", message:
            whatToSay, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Got it!", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    //---------------------
    //Button functions
    //---------------------
    @IBAction func downloadQuestions(_ sender: Any) {
        downloadQuestionsFile()
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
