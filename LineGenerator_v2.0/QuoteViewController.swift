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
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var lowerView: UIView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var quoteText: UILabel!
    
    var selectedCategory: CategoryModel?
    // on based category call the specific service
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteText.adjustsFontSizeToFitWidth = true
        
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
        upperView.backgroundColor = outerColor
        lowerView.backgroundColor = outerColor
    }
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        os_log("wow it worked")
    } 
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func clicked(_ sender: Any) {
        //feedItems
        
        
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
    
    // MARK: Private Methods
    
    // method to set appropriate color to background and views based on category color string
    // also set the color of the text of the button and the texts to look better
    private func setColor(color: String){
        
        switch color {
            case "brown":
                outerColor = UIColor.brown
            case "red":
                outerColor = UIColor.red
            case "yellow":
                outerColor = UIColor.yellow
            case "grey":
                outerColor = UIColor.gray
            case "purple":
                outerColor = UIColor.purple
            case "lgiht blue":
                outerColor = UIColor.blue
            case "pink":
                outerColor = UIColor.purple // change to pink
            case "orange":
                outerColor = UIColor.orange
            case "green":
                outerColor = UIColor.green
            case "black":
                outerColor = UIColor.black
            default:
                outerColor = UIColor.blue
        }
    }
    
    
}
