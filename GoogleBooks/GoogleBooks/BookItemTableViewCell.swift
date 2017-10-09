//
//  BookItemTableViewCell.swift
//  GoogleBooks
//
//  Created by Yerbolat Beisenbek on 09.10.17.
//  Copyright © 2017 1encore. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
