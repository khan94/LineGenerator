//
//  HomeModel.swift
//  LineGenerator_v2.0
//
//  Created by Khan Julmagambetov on 2017-03-23.
//  Copyright © 2017 AJ. All rights reserved.
//

import Foundation
import os.log

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    //var cateName: String?
    var catOrLine: Bool? // defines whether input is "" or some category
    
    // have if statement to check if we are looking for categories or lines
    
    let urlPath: String = "http://aslai.tech/service.php"
    
    
    
    // let args = (categoryName: String) 
    // if string is empty we are calling the list of categories
    // else call the lines of category categoryName 
    // create urlPath based on categoryName 
    //(i.e. if categoryName="comps" url="http://aslai.tech"+categoryName+".php"
    
    func downloadItems(catName: String) {
        //cateName = catName
        // have if statement here
        let url: NSURL
        catOrLine = catName != ""
        if catOrLine! {
            //change the urlPath or let other variable hold url path
            let urlPathLine: String = "http://aslai.tech/" + catName + ".php"
            url = NSURL(string: urlPathLine)!
        }
        else{
            url = NSURL(string: urlPath)!
        }
        
       // url = NSURL(string: urlPath)!
        var session: URLSession!
        let configuration = URLSessionConfiguration.default
        
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: url as URL)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data);
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSArray = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let categories: NSMutableArray = NSMutableArray()
        let lines: NSMutableArray = NSMutableArray()
        
        // COME BACK AND PIPE IF CATEGORIES OR LINES
        
        
        for i in 0...(jsonResult.count - 1)
        {
            jsonElement = jsonResult[i] as! NSDictionary
                
            
                
            //the following insures none of the JsonElement values are nil through optional binding
                
            if catOrLine! {
                let line = LineModel()
                // parse the lines
                if let content = jsonElement["value"] as? String,
                    let category = jsonElement["name"] as? String
                {
                    line.content = content
                    line.category = category
                }
                
                lines.add(line)
            }
            else{
                let category = CategoryModel()
                
                if let name = jsonElement["name"] as? String,
                    let color = jsonElement["color"] as? String
                {
                    category.name = name
                    category.color = color
                }
                
                categories.add(category)
            }
        }
        
        
        DispatchQueue.main.async( execute: {
            if self.catOrLine! {
                self.delegate.itemsDownloaded(items: lines)
            }
            else{
                self.delegate.itemsDownloaded(items: categories)
            }
        })
        
    }
    
}
