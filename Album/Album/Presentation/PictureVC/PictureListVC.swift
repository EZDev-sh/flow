//
//  PictureListVC.swift
//  Album
//
//  Created by 조재훈 on 2023/01/20.
//

import UIKit

class PictureListVC: UIViewController {
    let pictureCollection: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
        
    }()
    
    private let cellSpacing: CGFloat = 4
    
    var albumModel: AlbumModel?
    var images: [UIImage] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layouts()
        fetch()
    }

}

extension PictureListVC {
    private func attribute() {
        title = albumModel?.title
        view.backgroundColor = .systemBackground
        pictureCollection.delegate = self
        pictureCollection.dataSource = self
        pictureCollection.register(PictureCell.self, forCellWithReuseIdentifier: "pictureCell")
    }
    
    private func layouts() {
        view.addSubview(pictureCollection)
        pictureCollection.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func fetch() {
        if let albumImages = albumModel?.pictures {
            images = albumImages
            pictureCollection.reloadData()
        }
        
    }
}

extension PictureListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PictureCell
        
        let img = images[indexPath.item]
        
        cell.imageView.image = img
        
        return cell
    }
    
    
}

extension PictureListVC: UICollectionViewDelegate {
    
}

extension PictureListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - cellSpacing
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellSpacing
    }
}
