//
//  QuoteViewController.swift
//  LineGenerator_v2.0
//
//  Created by Khan Julmagambetov on 2017-03-23.
//  Copyright © 2017 AJ. All rights reserved.
//


import Foundation
import UIKit
import os.log

class QuoteViewController : UIViewController, HomeModelProtocal {
    
    
    // MARK: Properties
    var feedItems: NSArray = NSArray()
    var mem: Int?
    
    var bgColor: UIColor?
    var outerColor: UIColor?
    
    //MARK: UI Properties
    
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var lowerView: UIView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var quoteText: UILabel!
    
    @IBOutlet weak var buttonText: UIButton!
    var selectedCategory: CategoryModel?
    // on based category call the specific service
    
    
    override func viewDidLoad() {
        
        // MARK: Constraints
        
        
        
        super.viewDidLoad()
//        clipButton.isEnabled = false
        quoteText.adjustsFontSizeToFitWidth = true
        
//        clipButton.setImage(UIImage(named: "normal_clip"), for: UIControlState.normal)
        
        
        if selectedCategory != nil {
            os_log("it worked")
            categoryTitle.text = selectedCategory?.name
        }
        else{
            os_log("needs a fix")
        }
        let homeModel = HomeModel()
        homeModel.delegate = self
        let tempCat: String = (selectedCategory?.name)!
        homeModel.downloadItems(catName: tempCat.lowercased())
        setColor(color: (selectedCategory?.color)!)
        // set colors of views
        self.view.backgroundColor = bgColor
        upperView.backgroundColor = outerColor
        lowerView.backgroundColor = outerColor
        // set colors of texts
        quoteText.textColor = outerColor
        categoryTitle.textColor = bgColor
        buttonText.setTitleColor(bgColor, for: UIControlState.normal)
        //clipButton.setTitleColor(outerColor, for: UIControlState.normal)
    }
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        os_log("wow it worked")
    } 
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        // animation
        super.viewDidAppear(animated)
        
        // CHANGE THE NAMES
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.quoteConstraint.constant += self.view.bounds.width
//            self.view.layoutIfNeeded()
//        }, completion: nil)
    }
    @IBAction func clicked(_ sender: Any) {
//        clipButton.isEnabled = true
        // MARK: Animation
        self.quoteText.center.x -= self.view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.quoteText.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        // MARK: Logic
        // choose the right quote so there is no repitition
        let counts: Int = feedItems.count
        var rand: Int
        // simplest way to keep the quotes from getting repeated
        repeat {
            if counts == 0{
                quoteText.text = "There are no pick up lines in this category"
                return
            }
            rand = Int(arc4random_uniform(UInt32(counts)))
        }
            while rand == mem && counts != 1
        mem = rand
        // set quoteText.text to feedItems[rand]
        quoteText.text = (feedItems[rand] as! LineModel).content
    }
    
    @IBAction func toClipBoard(_ sender: Any) {
        UIPasteboard.general.string = quoteText.text
    }
    
    
    
    
    
    
    
    
    // MARK: Private Methods
    
    // method to set appropriate color to background and views based on category color string
    // also set the color of the text of the button and the texts to look better
    private func setColor(color: String){
        
        switch color {
            
        case "brown":
                // #E9AFA3 - inner -> rgb(233,175,163)
                // #685044 - outer -> rgb(104,80,68)
                outerColor = UIColor(colorLiteralRed: 104/255, green: 80/255, blue: 68/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 233/255, green: 175/255, blue: 163/255, alpha: 1)
            
            case "red":
                outerColor = UIColor.red
                bgColor = UIColor.white
            case "yellow":
                // #FA9F42 -> rgb(250,159,66)
                // #2b4162 -> rgb(43,65,98)
                outerColor = UIColor(colorLiteralRed: 42/255, green: 65/255, blue: 98/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 250/255, green: 159/255, blue: 66/255, alpha: 1)
            case "grey":
                // #272D2D -> rgb(39,45,45)
                // #A39BA8 -> rgb(163,155,168)
                outerColor = UIColor(colorLiteralRed: 39/255, green: 45/255, blue: 45/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 163/255, green: 155/255, blue: 168/255, alpha: 1)
            case "purple":
                // #D4E79E -> rgb(212,231,158)
                // #922D50 -> rgb(146,45,80)
                outerColor = UIColor(colorLiteralRed: 146/255, green: 45/255, blue: 80/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 212/255, green: 231/255, blue: 158/255, alpha: 1)
            case "light blue":
                // #AEC5EB -> rgb(174,197,235)
                // #F9DEC9 -> rgb(249,222,201)
                outerColor = UIColor(colorLiteralRed: 174/255, green: 197/255, blue: 235/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 249/255, green: 222/255, blue: 201/255, alpha: 1)
            case "green":
                // #4F772D -> rgb(79,119,45)
                // #2E2D4D -> rgb(46,45,77)
                outerColor = UIColor(colorLiteralRed: 79/255, green: 119/255, blue: 45/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 46/255, green: 45/255, blue: 77/255, alpha: 1)
            case "pink":
                outerColor = UIColor.purple // change to pink
            case "orange":
                outerColor = UIColor.orange
            case "black":
                // #D4E79E -> rgb(212,231,158)
                // #922D50 -> rgb(146,45,80)
                outerColor = UIColor(colorLiteralRed: 146/255, green: 45/255, blue: 80/255, alpha: 1)
                bgColor = UIColor(colorLiteralRed: 212/255, green: 231/255, blue: 158/255, alpha: 1)
            default:
                outerColor = UIColor.blue
        }
        self.view.backgroundColor = bgColor
    }
    
    
}
