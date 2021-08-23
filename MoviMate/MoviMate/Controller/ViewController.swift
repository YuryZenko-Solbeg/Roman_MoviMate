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
    
    private static let startButtonCornerRadius: CGFloat = 8
    private static let startButtonName = "START GAME"
    private static let startButtonAttributeKern: CGFloat = 10.0
    private static let startButtonAttributeFont: UIFont = UIFont.systemFont(ofSize: 10)
    private static let startButtonAttributeColor: UIColor = UIColor.white
    private static let settingsButtonCornerRadius: CGFloat = 8
    private static let settingsViewControllerIdentifie = "languageSetings"
    private static let setNavigationBarHiddenState = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(ViewController.setNavigationBarHiddenState, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = ViewController.startButtonCornerRadius
        settingsButton.layer.cornerRadius = ViewController.settingsButtonCornerRadius
        
        let attributedTitle = NSAttributedString(string: ViewController.startButtonName, attributes:
                                                    [NSAttributedString.Key.kern: ViewController.startButtonAttributeKern,
                                                     NSAttributedString.Key.font: ViewController.startButtonAttributeFont,
                                                     NSAttributedString.Key.foregroundColor: ViewController.startButtonAttributeColor
        ])
        startButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func start(_ sender: Any) {
        
        _ = networkManager.getListOfGenre(completionHandler: { result in
            
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
        
        let storyBoard = UIStoryboard(name: ViewController.uIStoryboardIdentifie, bundle: nil)
        
        guard let genreView = storyBoard.instantiateViewController(identifier: ViewController.genreViewControllerIdentifie) as? GenreViewController else {
            
            return
        }
        
        genreView.genreList = list.genres
        
        navigationController?.pushViewController(genreView, animated: true)
    }
    
    func pushSettingViewController() {
        
        let storyBoard = UIStoryboard(name: ViewController.uIStoryboardIdentifie, bundle: nil)

        guard let settingView = storyBoard.instantiateViewController(identifier: ViewController.settingsViewControllerIdentifie) as? SettingsViewController else {
            
            return
        }
        
        navigationController?.pushViewController(settingView, animated: true)
    }
}

