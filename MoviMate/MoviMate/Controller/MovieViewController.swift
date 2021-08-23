//
//  MovieViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class MovieViewController: BaseViewController {

    @IBOutlet private weak var collectonView: UICollectionView!
    
    private let cache = NSCache<NSNumber, UIImage>()
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = navigationItem.titleView as? UILabel
        titleLabel?.text = "Movies"
        
        collectonView.delegate = self
        collectonView.dataSource = self
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieList.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewController.moiveReuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            
            return UICollectionViewCell()
        }
                
        movieCell.setMovieCell(title: movieList[indexPath.item].title, additional: movieList[indexPath.item].overview)
        movieCell.ratingView.setStarsRating(rating: Int(movieList[indexPath.item].rating))
        
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width * 0.86, height: view.frame.width * 0.34)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? MovieCollectionViewCell else { return }
        
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            
            print("Using a cached image for item: \(itemNumber)")
            cell.setImage(image: cachedImage)
        } else {
            
            DispatchQueue.global(qos: .utility).async {
                
                guard let image = UIImage(data: self.networkManager.getMoviePoster(path: self.movieList[indexPath.item].icon)) else {
                return
            }
                DispatchQueue.main.async {
                    
                    cell.setImage(image: image)
                    self.cache.setObject(image, forKey: itemNumber)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        networkManager.getMovieById(id: movieList[indexPath.item].id, completionHandler: { (result) in
            switch result {
            
            case .success(let movie):
                
                DispatchQueue.main.async {
                    
                self.pushMovieViewController(movie)
                }
                
            case .failure(let error):
                self.pushAlertViewController()
                print(error)
            }
        })
       }
}

private extension MovieViewController {
    
    func pushMovieViewController(_ movie: MovieDescription) {
        
        let storyBoard = UIStoryboard(name: MovieViewController.uIStoryboardIdentifie, bundle: nil)
        
        guard let movieView = storyBoard.instantiateViewController(identifier: MovieViewController.movieDescriptionViewControllerIdentifie) as? MovieDescriptionViewController else {
            
            return
        }
        
        movieView.movie = movie
        
        navigationController?.pushViewController(movieView, animated: true)
    }
}

