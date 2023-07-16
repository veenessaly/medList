//
//  MedCell.swift
//  medReminder
//
//  Created by VANESSA DOWD on 7/8/23.
//

import UIKit

class MedCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
//    @IBOutlet weak var takenLabel: UILabel!
//    @IBOutlet weak var remainingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
