//
//  GenreCollectionViewCell.swift
//  MoviMate
//
//  Created by Roman Alikevich on 12.08.21.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setGenreCell(image: UIImage, title: String) {
        icon.image = image
        self.title.text = title
    }
}
