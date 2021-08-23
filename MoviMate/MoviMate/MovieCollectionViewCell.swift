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
    
    private static let cornerRadiusValue: CGFloat = 8
    private static let shadowWidth: CGFloat = 0.0
    private static let shadowHeight: CGFloat = 2.0
    private static let shadowOpacity: Float = 0.8
    private static let shadowRadius: CGFloat = 2
    private static let shadowCornerRadius: CGFloat = 4.0
    private static let iconViewMasksToBounds = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = MovieCollectionViewCell.cornerRadiusValue
        icon.layer.cornerRadius = MovieCollectionViewCell.cornerRadiusValue
        
        icon.layer.shadowColor = UIColor.black.cgColor
        icon.layer.shadowOffset = CGSize(width: MovieCollectionViewCell.shadowWidth, height: MovieCollectionViewCell.shadowHeight)
        icon.layer.shadowOpacity = MovieCollectionViewCell.shadowOpacity
        icon.layer.shadowRadius = MovieCollectionViewCell.shadowRadius
        icon.layer.masksToBounds = MovieCollectionViewCell.iconViewMasksToBounds
        icon.layer.cornerRadius = MovieCollectionViewCell.shadowCornerRadius
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
