//
//  SettingsViewController.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settingArray = ["LANGUAGE OPTION", "RESOLUSION OPTIONS"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        collectionView.register(UINib(nibName: "flagView", bundle: nil), forCellWithReuseIdentifier: "flagsView")
//        collectionView.register(UINib(nibName: "segmentView", bundle: nil), forCellWithReuseIdentifier: "segmentsView")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
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
        
        return CGSize(width: view.frame.width * 0.87, height: view.frame.width * 0.54)
    }
}
