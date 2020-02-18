//
//  DetailViewController.swift
//  Challenge10-12
//
//  Created by  Vladislav Bondarev on 18.02.2020.
//  Copyright © 2020 Vladislav Bondarev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photo: UIImage?
    var titlePhoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = titlePhoto
        
        navigationItem.largeTitleDisplayMode = .never
        imageView.image  = photo
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
