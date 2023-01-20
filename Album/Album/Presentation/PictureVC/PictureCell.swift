//
//  PictureCell.swift
//  Album
//
//  Created by 조재훈 on 2023/01/20.
//

import UIKit

class PictureCell: UICollectionViewCell {
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PictureCell {
    private func attribute() {
        
    }
    
    private func layouts() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
