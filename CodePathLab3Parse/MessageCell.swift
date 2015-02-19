//
//  MessageCell.swift
//  CodePathLab3Parse
//
//  Created by Steffan Chartrand on 2/18/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
