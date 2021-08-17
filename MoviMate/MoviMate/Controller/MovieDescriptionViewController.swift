//
//  MovieDescriptionViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class MovieDescriptionViewController: BaseViewController {

    var movie: MovieDescription!
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
