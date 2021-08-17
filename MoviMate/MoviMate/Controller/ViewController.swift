//
//  ViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 6.08.21.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 8
        settingsButton.layer.cornerRadius = 8
        
        navigationController?.setNavigationBarHidden(true, animated: false)
//        let mutabletitle = NSMutableAttributedString(string: "START")

        let attributedTitle = NSAttributedString(string: "START GAME", attributes:
                                                    [NSAttributedString.Key.kern: 10.0,
                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                                                     NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        startButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func start(_ sender: Any) {
        let genreList = networkManager.getListOfGenre(completionHandler: { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let genreList):
                    self.openGenreViewController(genreList)
                case .failure(let error):
                    self.pushAlertViewController()
                    print(error)
                }
            }
        })
    }
    @IBAction func openSetting(_ sender: Any) {
        pushSettingViewController()
    }
}

private extension ViewController {
    
    func openGenreViewController(_ list: GenreList) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let genreView = storyBoard.instantiateViewController(identifier: "showListOfGenres") as? GenreViewController else {
            return
        }
        
        genreView.genreList = list.genres
        
        navigationController?.pushViewController(genreView, animated: true)
    }
    
    func pushSettingViewController() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        guard let settingView = storyBoard.instantiateViewController(identifier: "languageSetings") as? SettingsViewController else {
            return
        }
        
        navigationController?.pushViewController(settingView, animated: true)
    }
}

