//
//  SelectionTableViewCell.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel = UILabel()
        titleLabel.constrainToSuperView(contentView, top: 8, bottom: 8, leading: 20, trailing: 20)
    }

}
