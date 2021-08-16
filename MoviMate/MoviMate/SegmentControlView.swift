//
//  SegmentControlView.swift
//  MoviMate
//
//  Created by Roman Alikevich on 13.08.2021.
//

import UIKit

class SegmentControlView: UIView {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        segmentView.removeAllSegments()
        segmentView.insertSegment(withTitle: "LOW", at: 0, animated: false)
        segmentView.insertSegment(withTitle: "MEDDIUM", at: 1, animated: false)
        segmentView.insertSegment(withTitle: "HIGH", at: 2, animated: false)
        
        segmentView.selectedSegmentIndex = 0
    }
}
