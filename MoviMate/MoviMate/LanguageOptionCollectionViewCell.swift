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
        
        stackView.spacing = 5
        stackView.layer.cornerRadius = 8
    }
    
    func addCellSubview(cellState: SettingCellState, completionHandler: @escaping ([UIView])-> Void) {
        
        switch cellState {
        
        case .lan:
            
            guard let englishView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            englishView.flagIcon.image = UIImage(named: "free-icon-united-states-197484")!
            englishView.name.text = "English"
            englishView.flagState.image = UIImage(named: "radio_on")!
            
            englishView.layer.borderWidth = 0.4
            englishView.layer.borderColor = UIColor.yellow.cgColor
            englishView.layer.cornerRadius = 8

            guard let russianView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            russianView.flagIcon.image = UIImage(named: "free-icon-russia-197408")!
            russianView.name.text = "Russian"
            russianView.flagState.image = UIImage(named: "radio_off")!
            
            russianView.layer.borderWidth = 0.4
            russianView.layer.borderColor = UIColor.yellow.cgColor
            russianView.layer.cornerRadius = 8
            
//            stackView.distribution = .fillProportionally
            stackView.alignment = .center
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
                
            stackView.addArrangedSubview(englishView)
            stackView.addArrangedSubview(russianView)
            
            completionHandler(stackView.subviews)
            
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
                segmentView.segmentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
                segmentView.segmentView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                segmentView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95)
            ])

            
            completionHandler(stackView.subviews)
        }
    }
}
