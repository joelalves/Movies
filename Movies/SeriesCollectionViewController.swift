//
//  SeriesCollectionViewController.swift
//  Movies
//
//  Created by Joel Alves on 09/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellSerie"

class SeriesCollectionViewController: UICollectionViewController {
    
    var user: User?
    var series: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OmdbManager.trendingSeries { () in
            self.reloadData()
        }
        
        DataStore.sharedInstance.getUser { (user) in
            self.user = user
        }
        
        self.collectionView?.refreshControl = UIRefreshControl()
        self.collectionView?.refreshControl?.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        self.reloadData();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let refreshControl = self.collectionView?.refreshControl, refreshControl.isRefreshing {
            self.collectionView?.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        }
        
    }
    
    func reloadData() {
        self.collectionView?.refreshControl?.beginRefreshing()
        DataStore.sharedInstance.getSeries { (series) in
            self.collectionView?.refreshControl?.endRefreshing()
            self.series = series
            self.collectionView?.reloadData()
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.series?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSerie", for: indexPath)
        
        // Configure the cell
        if let serie = self.series?[indexPath.row],
            let cell = cell as? SeriesCollectionViewCell{
            print("sasdasdasdadasda");
            cell.prepareForReuse()
            cell.titleLabel.text = serie.title
            print(serie.id!)
            if serie.id != nil {
                print("not nil")
                FanartManager.images(for: serie.id!, completion: { (movieImage) in
                    if let url = URL(string: movieImage.preview) {
                        cell.task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                            if let data = data {
                                //Weak para conseguirmos ter acesso a cell com uma mera referência. Se entretanto a cell desaparecer passa a nil
                                DispatchQueue.main.async { [weak cell] in
                                    if cell?.task?.state != .canceling && cell?.task?.state != .suspended {
                                        let image = UIImage(data: data)
                                        cell?.posterImageView.image = image
                                        cell?.setNeedsLayout()
                                        cell?.layoutSubviews()
                                    } else {
                                        cell?.posterImageView.image = nil
                                    }
                                }
                            }
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        })
                        cell.task?.resume()
                    }
                })
            }
        }

        return cell
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            //loadSomeDataAndIncreaseDataLengthFunction()
            //self.reloadData()
            print("next page")
        }
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
