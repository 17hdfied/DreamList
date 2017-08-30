//
//  ItemCell.swift
//  DreamList
//
//  Created by Hardik Wason on 26/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var title_cell: UILabel!
    @IBOutlet weak var price_cell: UILabel!
    @IBOutlet weak var desc_cell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(item: Item){
        
        title_cell.text = item.title
        price_cell.text = "\(item.price)"
        desc_cell.text = item.details
        image_cell.image = item.toImage?.image as? UIImage
        
    }

}
