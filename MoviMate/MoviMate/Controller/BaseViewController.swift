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
    }
    
    func pushAlertViewController() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let movieView = storyBoard.instantiateViewController(identifier: "alertViewController") as? CustomAlertViewController else {
            return
        }
        
        navigationController?.pushViewController(movieView, animated: true)
    }
}
