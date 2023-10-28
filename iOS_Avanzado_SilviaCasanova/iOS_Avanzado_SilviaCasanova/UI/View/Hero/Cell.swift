//
//  Cell.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit
import Kingfisher

class Cell: UITableViewCell {

    
    var identifier = "Cell"
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func updateData(with hero: Hero) {
        heroName.text = hero.name
        heroImage.kf.setImage(with: hero.photo)
        heroDescription.text = hero.description
    }
  
    
}
