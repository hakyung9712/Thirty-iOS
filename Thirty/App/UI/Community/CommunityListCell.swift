//
//  CommunityListCell.swift
//  Thirty
//
//  Created by 송하경 on 2022/07/24.
//

import UIKit

class CommunityListCell: UITableViewCell {
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeOrderLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var challengeCreatedAtLabel: UILabel!
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeImageStackView: UIStackView!
    @IBOutlet weak var moreButton: UIButton!
    
    static var identifier = "CommunityListCell"
    
    var makeExpand: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func expandCell() {
        makeExpand?(true)
    }

}
