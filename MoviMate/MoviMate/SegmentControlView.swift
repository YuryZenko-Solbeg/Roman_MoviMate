//
//  SegmentControlView.swift
//  MoviMate
//
//  Created by Roman Alikevich on 13.08.2021.
//

import UIKit

class SegmentControlView: UIView {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    private static let pixelSizeLowValue = 200
    private static let pixelSizeMeddiumValue = 300
    private static let pixelSizeHighValue = 500
    
    private static let pixelSizeLowName = "LOW"
    private static let pixelSizeMeddiumName = "MEDDIUM"
    private static let pixelSizeHighName = "HIGH"

    
    enum PixelSize: Int {
        
        case small = 0
        case meddium
        case high
        
        func getSize() -> Int {
            
            switch self {
            case .small:
                
                return pixelSizeLowValue
            case .meddium:
                
                return pixelSizeMeddiumValue
            case .high:
                
             return pixelSizeHighValue
            }
        }
        
        func getElement(size: Int) -> PixelSize {
            
            switch size {
            case pixelSizeLowValue:
                return .small
            case pixelSizeMeddiumValue:
                return .meddium
            case pixelSizeHighValue:
                return .high
            default:
                fatalError("Incorrect size in PixelSize enum")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .black
        segmentView.layer.borderWidth = 0.4
        segmentView.layer.borderColor = UIColor.yellow.cgColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        segmentView.removeAllSegments()
        segmentView.insertSegment(withTitle: SegmentControlView.pixelSizeLowName, at: 0, animated: false)
        segmentView.insertSegment(withTitle: SegmentControlView.pixelSizeMeddiumName, at: 1, animated: false)
        segmentView.insertSegment(withTitle: SegmentControlView.pixelSizeHighName, at: 2, animated: false)
        

        let size = UserDefaultManager.shared.getPixelSize()
        let pixelSize = PixelSize.getElement(PixelSize(rawValue: 0)!)
        segmentView.selectedSegmentIndex = pixelSize(size!).rawValue
        
        segmentView.addTarget(self, action: #selector(self.swipeHandler(_:)), for: .valueChanged)
    }
    
    @objc func swipeHandler(_ segment: UISegmentedControl) {

        let index = segment.selectedSegmentIndex
        let pixelElement = PixelSize(rawValue: index)!
        let size = PixelSize.getSize(pixelElement)
        self.reloadSegment(size: size())
    }
    
    func reloadSegment(size: Int) {
        
        UserDefaultManager.shared.updateStorage([UserDefaultManager.WareHouseType.pixelSize.rawValue:size])
    }
}
