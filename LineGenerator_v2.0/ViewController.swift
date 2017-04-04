//
//  ViewController.swift
//  LineGenerator_v2.0
//
//  Created by Khan Julmagambetov on 2017-03-23.
//  Copyright © 2017 AJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocal {

    //Properties
    var feedItems: NSArray = NSArray()
    var selectedCategory : CategoryModel = CategoryModel()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems(catName: "")
        //homeModel.data
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the category to be shown
        let item: CategoryModel = feedItems[indexPath.row] as! CategoryModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.name
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to var
        selectedCategory = feedItems[indexPath.row] as! CategoryModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "quoteSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        // Get reference to the destination view controller
        let quoteVC  = segue!.destination as! QuoteViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        quoteVC.selectedCategory = selectedCategory
    }
    
}

