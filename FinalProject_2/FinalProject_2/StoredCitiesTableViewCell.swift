//
//  StoredCitiesTableViewCell.swift
//  FinalProject_2
//
//  Created by user182505 on 12/19/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import UIKit

class StoredCitiesTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var subTitle: UILabel!
    
    func setStoredCitiesData(entity : CitiesStorage){
        
        title.text = entity.cityName
        subTitle.text = entity.countryName
    }

  
}
