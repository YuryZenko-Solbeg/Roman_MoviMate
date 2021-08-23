//
//  LanguageOptionCollectionViewCell.swift
//  MoviMate
//
//  Created by Roman Alikevich on 13.08.2021.
//

import UIKit



class LanguageOptionCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    enum SettingCellState {
        case lan, segment
    }
    
    var cellState: SettingCellState?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.spacing = 10
        stackView.layer.cornerRadius = 8
    }
    
    func addCellSubview(cellState: SettingCellState) {
        
        switch cellState {
        
        case .lan:
            
            guard let englishView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            englishView.flagIcon.image = UIImage(named: "free-icon-united-states-197484")!
            englishView.name.text = "ENGLISH"
            
            var lan = "radio_off"
            if UserDefaultManager.shared.getLanguage() == "en" {
                lan = "radio_on"
            }
            englishView.flagState.image = UIImage(named: lan)!
            
            englishView.layer.borderWidth = 0.4
            englishView.layer.borderColor = UIColor.yellow.cgColor
            englishView.layer.cornerRadius = 8

            guard let russianView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            russianView.flagIcon.image = UIImage(named: "free-icon-russia-197408")!
            russianView.name.text = "RUSSIAN"
            
            lan = "radio_off"
            if UserDefaultManager.shared.getLanguage() == "ru" {
                lan = "radio_on"
            }
            russianView.flagState.image = UIImage(named: lan)!
            
            russianView.layer.borderWidth = 0.4
            russianView.layer.borderColor = UIColor.yellow.cgColor
            russianView.layer.cornerRadius = 8
            
            stackView.alignment = .center
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: 15, left: 10, bottom: 15, right: 10)
                
            stackView.addArrangedSubview(englishView)
            stackView.addArrangedSubview(russianView)
            
            for view in stackView.subviews {
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(_:)))
                view.addGestureRecognizer(tap)
            }
        case .segment:
            
            guard let segmentView = Bundle.main.loadNibNamed("SegmentControlView", owner: self, options: nil)?[0] as? SegmentControlView else {
                return
            }
            
            stackView.distribution = .fill
            stackView.alignment = .center
          
            stackView.addArrangedSubview(segmentView)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            segmentView.segmentView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                segmentView.segmentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.33),
                segmentView.segmentView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                segmentView.segmentView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95)
            ])
        }
    }
    
    func reloadLanguageView(language: String) {
        
        guard let languageArray = stackView.arrangedSubviews as? [LanguageView] else {
            return
        }
        
        for view in languageArray {
            if view.name.text == language {
                view.flagState.image = UIImage(named: "radio_on")!
            } else {
                view.flagState.image = UIImage(named: "radio_off")!
            }
        }
        
        var lan = ""
        if language == "ENGLISH" {
            lan = "en"
        } else {
            lan = "ru"
        }
        
        UserDefaultManager.shared.updateStorage([UserDefaultManager.WareHouseType.language.rawValue:lan])
    }
    
    @objc func tapHandler(_ gestureRecognizer: UIGestureRecognizer? = nil) {
        
        guard let lan = gestureRecognizer?.view as? LanguageView else {
            return
        }

        self.reloadLanguageView(language: lan.name.text!)
    }
}
