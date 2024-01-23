//
//  MoviesCollectionViewCell.swift
//  Movies
//
//  Created by Joel Alves on 09/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    var task: URLSessionTask?
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
        self.task?.cancel()
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
