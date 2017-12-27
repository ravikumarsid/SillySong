//
//  ViewController.swift
//  Silly Song
//
//  Created by Ravi Kumar Venuturupalli on 12/26/17.
//  Copyright © 2017 Ravi Kumar Venuturupalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shortNameFromName (name:String) ->String {
        let vowels = CharacterSet.init(charactersIn: "aeiou")
        
        var shortenedName = name.lowercased().folding(options: .diacriticInsensitive, locale: NSLocale.current)
        let firstChar: Character = shortenedName[shortenedName.startIndex]
        
        
        if (String(firstChar).rangeOfCharacter(from: vowels) == nil) {
            shortenedName.remove(at: shortenedName.startIndex)
        }
        return shortenedName
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) ->String{
        var lyricsTemplate = lyricsTemplate
        let shortName = shortNameFromName(name: fullName)
        lyricsTemplate=lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        lyricsTemplate=lyricsTemplate.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        return lyricsTemplate
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        let nameOfPerson: String = nameField.text!
        let customLyrics: String = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameOfPerson)
        lyricsView.text = customLyrics
    }
    
    
    }

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

