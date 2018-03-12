//
//  CustomTableViewCell.swift
//  TaskHuman
//
//  Created by Akhilesh gandhi on 10/03/18.
//  Copyright © 2018 Moreyeahs. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
