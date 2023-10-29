//
//  Cell.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit
import Kingfisher

class Cell: UITableViewCell {

    static let estimatedHeight: CGFloat = 220
    static let identifier = "Cell"
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var container: UIView!
    
 
        override func awakeFromNib() {
        super.awakeFromNib()
            super.awakeFromNib()

                 container.layer.cornerRadius = 8
            container.layer.shadowColor = UIColor.gray.cgColor
            container.layer.shadowOffset = .zero
            container.layer.shadowRadius = 8
            container.layer.shadowOpacity = 0.4

            heroImage.layer.cornerRadius = 8
            heroImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]

                 selectionStyle = .none
    }
  
    func updateData(with hero: Hero) {
        heroName.text = hero.name
        heroImage.kf.setImage(with: hero.photo)
        heroDescription.text = hero.description
    }
  
    
}
