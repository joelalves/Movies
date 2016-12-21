//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Joel Alves on 09/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {
    
    var user: User?
    var movies: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
       OmdbManager.trendingMovies { (movies) in
            self.movies = movies
            self.collectionView?.reloadData()
        }

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
        return self.movies?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    
        // Configure the cell
        if let movie = self.movies?[indexPath.row],
            let cell = cell as? MoviesCollectionViewCell{
            cell.prepareForReuse()
            cell.titleLabel.text = movie.title
            let urlImage:String = "https://image.tmdb.org/t/p/w154"+movie.poster!;
            if let url = URL(string: urlImage) {
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
        }
    
        return cell
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
