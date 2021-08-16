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
    }
    
    func addCellSubview(cellState: SettingCellState) {
        switch cellState {
        case .lan:
            
            guard let englishView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            englishView.flagIcon.image = UIImage(named: "free-icon-united-states-197484")!
            englishView.name.text = "English"
            englishView.flagState.image = UIImage(named: "radio_on")!

            guard let russianView = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as? LanguageView else {
                return
            }
            
            russianView.flagIcon.image = UIImage(named: "free-icon-russia-197408")!
            russianView.name.text = "Russian"
            russianView.flagState.image = UIImage(named: "radio_off")!
                
                stackView.addArrangedSubview(englishView)
                
                stackView.addArrangedSubview(russianView)
            
        case .segment:
            
            guard let segmentView = Bundle.main.loadNibNamed("SegmentControlView", owner: self, options: nil)?[0] as? SegmentControlView else {
                return
            }
            
            stackView.distribution = .equalCentering
            
            stackView.addArrangedSubview(segmentView)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                segmentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25),
//                segmentView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.85),
            ])
        }
    }
}
