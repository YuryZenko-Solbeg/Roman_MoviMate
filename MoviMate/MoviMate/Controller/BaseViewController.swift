//
//  BaseViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 16.08.2021.
//

import UIKit

class BaseViewController: UIViewController {

    private(set) var networkManager: NetworkManager = NetworkManagerImpl(fetcher: NetworkFetcherImpl(service: NetworkServiceImpl()))
    
    static let uIStoryboardIdentifie = "Main"
    static let genreViewControllerIdentifie = "showListOfGenres"
    static let movieViewControllerIdentifie = "showListOfMovies"
    static let movieDescriptionViewControllerIdentifie = "showDescriptionOfMovie"
    static let aletViewControllerIdentifie = "alertViewController"
    static let genreReuseIdentifier = "customCell"
    static let moiveReuseIdentifier = "movieCell"
    static let defaultIcon = "default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackIndicator()
        setDefaultBackBarButton()
        setTitleView()
    }
    
    func pushAlertViewController() {
        
        let storyBoard = UIStoryboard(name: BaseViewController.uIStoryboardIdentifie, bundle: nil)
        
        guard let movieView = storyBoard.instantiateViewController(identifier: BaseViewController.aletViewControllerIdentifie) as? CustomAlertViewController else {
            
            return
        }
        
        navigationController?.pushViewController(movieView, animated: true)
    }
}

private extension BaseViewController {
    
    func setBackIndicator() {
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
    }
    
    func setDefaultBackBarButton() {
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func setTitleView() {
        
        let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.6, height: 40))
        lbNavTitle.textColor = UIColor.white
        lbNavTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = "Home"
        
        self.navigationItem.titleView = lbNavTitle
    }
}
