//
//  MovieCollectionViewCell.swift
//  MoviMate
//
//  Created by Roman Alikevich on 12.08.21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var additional: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        icon.layer.cornerRadius = 8
    }
    
    func setMovieCell(image: UIImage, title: String, additional: String) {
        icon.image = image
        self.title.text = title
        self.additional.text = additional
    }
    
    func setMovieCell(title: String, additional: String) {
        self.title.text = title
        self.additional.text = additional
    }
    
    func setImage(image: UIImage) {
        icon.image = image
    }
}
