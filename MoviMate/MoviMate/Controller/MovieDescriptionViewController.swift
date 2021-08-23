//
//  MovieDescriptionViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class MovieDescriptionViewController: BaseViewController {

    var movie: MovieDescription!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet private weak var firstView: UIView!
    @IBOutlet private weak var secondView: UIView!
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var titleMovie: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var budget: UILabel!
    @IBOutlet private weak var tagline: UILabel!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var genreList: UILabel!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = navigationItem.titleView as? UILabel
        titleLabel?.text = "Movies"
        
        scrollView.contentSize = CGSize(width: firstView.frame.width, height: firstView.frame.height + secondView.frame.height + 20)
        
        firstView.layer.cornerRadius = 8
        secondView.layer.cornerRadius = 8
        
        
//        icon.layer.masksToBounds = false
//        
//        icon.layer.shadowColor = UIColor.white.cgColor
//        icon.layer.shadowOpacity = 1
//        icon.layer.shadowOffset = CGSize(width: 5, height: 5)
//        icon.layer.shadowRadius = 6
//        icon.layer.shadowPath = UIBezierPath(rect: icon.bounds).cgPath
//        icon.layer.shouldRasterize = true
//        icon.layer.rasterizationScale = UIScreen.main.scale
//        
//        

        budget.layer.masksToBounds = true
        budget.layer.cornerRadius = 4
        
        tagline.layer.masksToBounds = true
        tagline.layer.cornerRadius = 4

        ratingView.layer.cornerRadius = ratingView.frame.width / 2

        titleMovie.text =  movie.title
        icon.image = UIImage(data: networkManager.getMoviePoster(path: movie.icon))
        
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "dd.MM.yyyy"
        status.text = formatter4.string(from: movie.releaseDate)
        
        budget.text = String(movie.budget)
        tagline.text = movie.tagline
        rating.text = String(movie.rating)
        
        var buff: String = ""
        for genre in movie.genreType {
            buff += genre.name + ", "
        }
        
        genreList.text = buff
        overview.text = movie.overview
    }

}
