//
//  AlbumCell.swift
//  Album
//
//  Created by 조재훈 on 2023/01/17.
//

import UIKit
import SnapKit
import Then

class AlbumCell: UITableViewCell {
    
    let thumbnail = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .systemGray4
    }
    
    let mainHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    let albumInfoVStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    let albumTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor(hex: "#000000")
    }
    
    let pictureCntLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor(hex: "#000000")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AlbumCell {
    private func attribute() {
        selectionStyle = .none
    }
    private func layouts() {
        contentView.addSubview(mainHStack)
        
        mainHStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        [thumbnail, albumInfoVStack].forEach {
            mainHStack.addArrangedSubview($0)
        }
        
        [albumTitleLabel, pictureCntLabel].forEach {
            albumInfoVStack.addArrangedSubview($0)
        }
        
        thumbnail.snp.makeConstraints {
            $0.width.height.equalTo(70)
        }
    }
    
    public func bind(_ model: AlbumModel) {
        thumbnail.image = model.thumbnail
        albumTitleLabel.text = model.title
        pictureCntLabel.text = String(format: "%d", model.count)
    }
}
