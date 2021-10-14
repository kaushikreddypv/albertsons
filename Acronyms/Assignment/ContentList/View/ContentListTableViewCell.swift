//
//  ContentListTableViewCell.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import UIKit

class ContentListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var lf: LF?  {
        didSet {
            contentTitleLabel.text = lf?.lf
        }
    }
    
}
