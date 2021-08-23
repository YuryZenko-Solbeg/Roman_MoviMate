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
    
    private static let stackViewSpace: CGFloat = 10
    private static let stackViewCornerRadius: CGFloat = 8
    private static let languageViewIdentifie = "LanguageView"
    private static let languageViewFlagIconEnglish = "free-icon-united-states-197484"
    private static let languageViewFlagIconRussian = "free-icon-russia-197408"
    private static let languageViewEnglishName = "ENGLISH"
    private static let languageViewRussianName = "RUSSIAN"
    private static let segmentControlViewIdentifie = "SegmentControlView"
    private static let flagStateRadioButtonOff = "radio_off"
    private static let flagStateRadioButtonOn = "radio_on"
    private static let languageBorderWidth: CGFloat = 0.4
    private static let languageBorderColor = UIColor.yellow.cgColor
    private static let languageCornerRadius: CGFloat = 8
    private static let stackViewMarginTop: CGFloat = 15
    private static let stackViewMarginLeft: CGFloat = 10
    private static let stackViewMarginBottom: CGFloat = 15
    private static let stackViewMarginRight: CGFloat = 10
    private static let stackViewHeightAnchor: CGFloat = 0.33
    private static let stackViewWidthAnchor: CGFloat = 0.95



    enum SettingCellState {
        case lan, segment
    }
    
    var cellState: SettingCellState?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.spacing = LanguageOptionCollectionViewCell.stackViewSpace
        stackView.layer.cornerRadius = LanguageOptionCollectionViewCell.stackViewCornerRadius
    }
    
    func addCellSubview(cellState: SettingCellState) {
        
        switch cellState {
        
        case .lan:
            
            guard let englishView = Bundle.main.loadNibNamed(LanguageOptionCollectionViewCell.languageViewIdentifie, owner: self, options: nil)?[0] as? LanguageView else {
                
                return
            }
            
            englishView.flagIcon.image = UIImage(named: LanguageOptionCollectionViewCell.languageViewFlagIconEnglish)!
            englishView.name.text = LanguageOptionCollectionViewCell.languageViewEnglishName
            
            var lan = LanguageOptionCollectionViewCell.flagStateRadioButtonOff
            
            if UserDefaultManager.shared.getLanguage() == UserDefaultManager.defaultSystemLanguge {
                
                lan = LanguageOptionCollectionViewCell.flagStateRadioButtonOn
            }
            englishView.flagState.image = UIImage(named: lan)!
            
            englishView.layer.borderWidth = LanguageOptionCollectionViewCell.languageBorderWidth
            englishView.layer.borderColor = LanguageOptionCollectionViewCell.languageBorderColor
            englishView.layer.cornerRadius = LanguageOptionCollectionViewCell.languageCornerRadius

            guard let russianView = Bundle.main.loadNibNamed(LanguageOptionCollectionViewCell.languageViewIdentifie, owner: self, options: nil)?[0] as? LanguageView else {
                
                return
            }
            
            russianView.flagIcon.image = UIImage(named: LanguageOptionCollectionViewCell.languageViewFlagIconRussian)!
            russianView.name.text = LanguageOptionCollectionViewCell.languageViewRussianName
            
            lan = LanguageOptionCollectionViewCell.flagStateRadioButtonOff
            
            if UserDefaultManager.shared.getLanguage() == UserDefaultManager.systemRussianLanguge {
                
                lan = LanguageOptionCollectionViewCell.flagStateRadioButtonOn
            }
            russianView.flagState.image = UIImage(named: lan)!
            
            russianView.layer.borderWidth = LanguageOptionCollectionViewCell.languageBorderWidth
            russianView.layer.borderColor = LanguageOptionCollectionViewCell.languageBorderColor
            russianView.layer.cornerRadius = LanguageOptionCollectionViewCell.languageCornerRadius
            
            stackView.alignment = .center
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: LanguageOptionCollectionViewCell.stackViewMarginTop, left: LanguageOptionCollectionViewCell.stackViewMarginLeft, bottom: LanguageOptionCollectionViewCell.stackViewMarginBottom, right: LanguageOptionCollectionViewCell.stackViewMarginRight)
                
            stackView.addArrangedSubview(englishView)
            stackView.addArrangedSubview(russianView)
            
            for view in stackView.subviews {
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(_:)))
                
                view.addGestureRecognizer(tap)
            }
        case .segment:
            
            guard let segmentView = Bundle.main.loadNibNamed(LanguageOptionCollectionViewCell.segmentControlViewIdentifie, owner: self, options: nil)?[0] as? SegmentControlView else {
                
                return
            }
            
            stackView.distribution = .fill
            stackView.alignment = .center
          
            stackView.addArrangedSubview(segmentView)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            segmentView.segmentView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                segmentView.segmentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: LanguageOptionCollectionViewCell.stackViewHeightAnchor),
                segmentView.segmentView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                segmentView.segmentView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: LanguageOptionCollectionViewCell.stackViewWidthAnchor)
            ])
        }
    }
    
    func reloadLanguageView(language: String) {
        
        guard let languageArray = stackView.arrangedSubviews as? [LanguageView] else {
            
            return
        }
        
        for view in languageArray {
            if view.name.text == language {
                
                view.flagState.image = UIImage(named: LanguageOptionCollectionViewCell.flagStateRadioButtonOn)!
            } else {
                
                view.flagState.image = UIImage(named: LanguageOptionCollectionViewCell.flagStateRadioButtonOff)!
            }
        }
        
        var lan = ""
        if language == LanguageOptionCollectionViewCell.languageViewEnglishName {
            
            lan = UserDefaultManager.defaultSystemLanguge
        } else {
            
            lan = UserDefaultManager.systemRussianLanguge
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
