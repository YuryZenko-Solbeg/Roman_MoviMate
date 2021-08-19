//
//  GenreViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class GenreViewController: BaseViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    var genreList: [Genres] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreList.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let genreName = genreList[indexPath.row].name.lowercased()
        let image = UIImage(named: genreName) ?? UIImage(named: "default")!
        cell.setGenreCell(image: image, title: genreName)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let genreId = genreList[indexPath.row].id
        networkManager.getListOfMovie(id: genreId, completionHandler: { (result) in

            DispatchQueue.main.async {
            switch result {
            case .success(let movieList):
                
                
                self.pushMovieViewController(movieList)
                
                
            case .failure(let error):
                self.pushAlertViewController()
                print(error)
            }
        }
            
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.407, height: view.frame.width * 0.37)
    }
}

private extension GenreViewController {
    
    func pushMovieViewController(_ list: MovieList) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieView = storyBoard.instantiateViewController(identifier: "showListOfMovies") as? MovieViewController else {
            return
        }
        
        movieView.movieList = list.items
        
        navigationController?.pushViewController(movieView, animated: true)
    }

}
