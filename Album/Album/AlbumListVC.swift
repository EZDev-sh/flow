//
//  AlbumListVC.swift
//  Album
//
//  Created by 조재훈 on 2023/01/17.
//

import UIKit

class AlbumListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        layouts()
        attribute()
    }
}

extension AlbumListVC {
    private func layouts() {
        
    }
    
    private func attribute() {
        view.backgroundColor = .green
    }
}
