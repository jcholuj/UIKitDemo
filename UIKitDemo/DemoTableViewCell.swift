//
//  DemoTableViewCell.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import UIKit
import SnapKit

class DemoTableViewCell: UITableViewCell {
    
    var demoImageView = UIImageView()
    var nameLabel = UILabel()

    override func awakeFromNib() { }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize() {
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    private func setupHierarchy() {
        contentView.addSubview(demoImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupLayout() {
        demoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(demoImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupProperties() {
        demoImageView.clipsToBounds = true
        demoImageView.layer.cornerRadius = 15
        demoImageView.layer.borderWidth = 1
        nameLabel.textColor = .black
    }
    
    func setupWithCharacter(_ character: Character) {
        demoImageView.load(urlString: character.imageUrl)
        nameLabel.text = character.fullName
    }
}
