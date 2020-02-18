//
//  Photo.swift
//  Challenge10-12
//
//  Created by  Vladislav Bondarev on 18.02.2020.
//  Copyright © 2020 Vladislav Bondarev. All rights reserved.
//

import UIKit

class Photo: NSObject,Codable {
    
    var image: String
    var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
}
