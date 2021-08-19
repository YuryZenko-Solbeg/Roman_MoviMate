//
//  BaseViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 16.08.2021.
//

import UIKit

class BaseViewController: UIViewController {

    private(set) var networkManager: NetworkManager = NetworkManagerImpl(fetcher: NetworkFetcherImpl(service: NetworkServiceImpl()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backItem
        
        let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.6, height: 40))
        lbNavTitle.textColor = UIColor.white
        lbNavTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = "Home"
        
        self.navigationItem.titleView = lbNavTitle
    }
    
    func pushAlertViewController() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let movieView = storyBoard.instantiateViewController(identifier: "alertViewController") as? CustomAlertViewController else {
            return
        }
        
        navigationController?.pushViewController(movieView, animated: true)
    }
}
