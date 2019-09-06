//
//  ListingTableViewCell.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    fileprivate weak var titleLabel: UILabel!
    fileprivate weak var descLabel: UILabel!
    fileprivate weak var cellImageView: UIImageView!
    
    fileprivate weak var titleTopConstraint: NSLayoutConstraint!
    fileprivate weak var descTopConstraint: NSLayoutConstraint!
    fileprivate weak var imageTopConstraint: NSLayoutConstraint!
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(withTitle title: String?, description: String?, image: UIImage?)
    {
        if title == nil
        {
            titleTopConstraint.constant = 0
        }
        else {
            titleTopConstraint.constant = 10
        }
        
        if description == nil
        {
            descTopConstraint.constant = 0
        }
        else {
            descTopConstraint.constant = 10
        }
        
        titleLabel.text = title
        descLabel.text = description
        
        imageTopConstraint.constant = 10
        if image == nil
        {
            cellImageView.image = UIImage(named: "placeholder")
        }
        else {
            cellImageView.image = image
        }
    }
}

extension ListingTableViewCell
{
    fileprivate func setupUIElements()
    {
        var label = UILabel()
        titleLabel = label
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.numberOfLines = 0
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        titleTopConstraint.isActive = true
        
        
        label = UILabel()
        descLabel = label
        contentView.addSubview(descLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.textAlignment = NSTextAlignment.left
        descLabel.font = UIFont.systemFont(ofSize: 12.0)
        descLabel.numberOfLines = 0
        
        descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        descTopConstraint = descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        descTopConstraint.isActive = true
        
        let imageView = UIImageView()
        cellImageView = imageView
        
        contentView.addSubview(cellImageView)
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.layer.borderColor = UIColor.black.cgColor
        cellImageView.layer.borderWidth = 1.0
        
        cellImageView.contentMode = .scaleAspectFit
        
        cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        imageTopConstraint = cellImageView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10)
        imageTopConstraint.isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
