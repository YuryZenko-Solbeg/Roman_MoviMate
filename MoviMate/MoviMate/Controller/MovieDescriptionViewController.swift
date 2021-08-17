//
//  MovieDescriptionViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class MovieDescriptionViewController: BaseViewController {

    var movie: MovieDescription!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var tagline: UILabel!
//    @IBOutlet weak var rating: UIView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genreList: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.layer.cornerRadius = 8
        secondView.layer.cornerRadius = 8
        ratingView.layer.cornerRadius = ratingView.frame.width / 2

        titleMovie.text =  movie.title
        icon.image = UIImage(data: networkManager.getMoviePoster(path: movie.icon))
//        status.text = movie.releaseDate
        
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "dd.MM.yyyy"
//        print(formatter4.string(from: movie.releaseDate))
        status.text = formatter4.string(from: movie.releaseDate)
        
        budget.text = String(movie.budget)
        tagline.text = movie.tagline
        rating.text = String(movie.rating)
        
        var buff: String = ""
        for genre in movie.genreType {
            buff += genre.name + ","
        }
        genreList.text = buff
        overview.text = movie.overview
    }

}
