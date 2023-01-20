//
//  AlbumListVC.swift
//  Album
//
//  Created by 조재훈 on 2023/01/17.
//

import UIKit
import SnapKit
import Then
import Photos

class AlbumListVC: UIViewController {
    let albumTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 85
        $0.backgroundColor = .systemBackground
    }
    
    var albums: [AlbumModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        layouts()
        attribute()
        fetchAlbums()
        albumTableView.reloadData()
    }
}

extension AlbumListVC {
    private func layouts() {
        view.addSubview(albumTableView)
        albumTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func attribute() {
        title = "앨범"
        view.backgroundColor = .systemBackground
        
        albumTableView.register(AlbumCell.self, forCellReuseIdentifier: "albumCell")
        albumTableView.rowHeight = UITableView.automaticDimension
        albumTableView.dataSource = self
        albumTableView.delegate = self
        
    }
    
    private func fetchAlbums() {
        let option = PHFetchOptions()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: option)
        
        userAlbums.enumerateObjects { obj, index, stop in
            if let albumName = obj.localizedTitle {
                let imageMgr = PHImageManager()
                
                let imageRequestOpt = PHImageRequestOptions()
                imageRequestOpt.isSynchronous = true
                imageRequestOpt.deliveryMode = .highQualityFormat
                
                
                
                let photoInAlbum = PHAsset.fetchAssets(in: obj, options: fetchOptions)
                
                if photoInAlbum.count > 0 {
                    
                    var newAlbum = AlbumModel(title: albumName,
                                              count: photoInAlbum.count,
                                              thumbnail: nil,
                                              pictures: [])
                    for i in 0..<photoInAlbum.count {
                        let resource = PHAssetResource.assetResources(for: photoInAlbum.object(at: i))
                        let fileName = resource.first?.originalFilename
                        
                        imageMgr.requestImage(for: photoInAlbum.object(at: i) , targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFit, options: imageRequestOpt, resultHandler: { image, error in

                            if let getImage = image {
                                if i == photoInAlbum.count - 1 {
                                    newAlbum.thumbnail = getImage
                                }
                                
                                newAlbum.pictures.append(getImage)
                            
                                
                            }
                        })
                    }
                    
                    self.albums.append(newAlbum)
                }
            }
            
            
        }
        
        albumTableView.reloadData()
    }
}

extension AlbumListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        
        let model = albums[indexPath.row]
        
        cell.bind(model)
        
        return cell
    }
    
    
}

extension AlbumListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = albums[indexPath.row]
        
        let pictureList = PictureListVC()
        pictureList.albumModel = model
        
        navigationController?.pushViewController(pictureList, animated: true)
    }
}
