//
//  SettingsViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    private var settingArray = ["LANGUAGE OPTION", "RESOLUSION OPTIONS"]

    @IBOutlet private weak var collectionView: UICollectionView!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let titleLabel = navigationItem.titleView as? UILabel
        titleLabel?.text = "Settings"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settingArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "languageOption", for: indexPath) as? LanguageOptionCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.title.text = settingArray[indexPath.item]
                
        cell.layer.cornerRadius = 8
        
        if indexPath.item == 0 {
            
            cell.addCellSubview(cellState: .lan)
        } else if indexPath.item == 1 {
            
            cell.addCellSubview(cellState: .segment)
        } else {
            
            fatalError("Didn't determine changing")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width * 0.87, height: view.frame.width * 0.5)
    }
}
