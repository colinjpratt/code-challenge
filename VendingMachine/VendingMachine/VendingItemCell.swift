//
//  VendingItemCell.swift
//  VendingMachine
//
//  Created by Colin on 5/14/20.
//  Copyright © 2020 Colin. All rights reserved.
//

import UIKit

protocol PurchaseDelegate: class {
    func itemWasPurchased(_ item: Vendable?)
}

class VendingItemCell: UITableViewCell {
    
    var item: Vendable? {
        willSet {
            self.nameLabel?.text = newValue?.name
            self.qunatityLabel?.text = newValue?.getDisplayableQuantity()
            self.priceLabel?.text = newValue?.getDisplayablePrice()
            self.imageView?.image = UIImage(named:newValue?.imageName ?? "")
        }
    }
    
    weak var delegate: PurchaseDelegate?
    
    @IBOutlet weak var itemBackgroundView: UIView?
    @IBOutlet weak var qunatityLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var itemImageView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemBackgroundView?.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func purchaseItem(_ sender: Any) {
        delegate?.itemWasPurchased(item)
    }
}
