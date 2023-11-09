//
//  DetailViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
 
    var hero: Hero?
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImage.layer.cornerRadius = 20.0
        initViews()
        // Do any additional setup after loading the view.
    }

    
    func initViews() {
        heroName.text = hero?.name
        heroImage.kf.setImage(with: hero?.photo)
        heroDescription.text = hero?.description
    }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

