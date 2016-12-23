//
//  MysTableViewController.swift
//  Movies
//
//  Created by Joel Alves on 22/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import UIKit

class MysTableViewController: UITableViewController {
    
    var movies: [Movie]?
    
    var sections: [Section] = SectionsData().getSectionsFromData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        
        self.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
            
            self.tableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        }
        
    }

    
    func reloadData() {
        self.refreshControl?.beginRefreshing()
        self.sections = SectionsData().getSectionsFromData()
        self.refreshControl?.endRefreshing()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        if let movie = sections[indexPath.section].items[indexPath.row] as Movie?,
            movie.title != "" {
            cell.textLabel?.text = "\(movie.title!)"
        }
        //cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]

        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("apagar")
            // Delete the row from the data source

            if let movie = sections[indexPath.section].items[indexPath.row] as Movie?{
                DataStore.sharedInstance.removeMovie(object: movie);
                self.sections[indexPath.section].delete(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            //self.reloadData()
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
