//
//  UITableView+Ext.swift
//  GithubFollowersApp
//
//  Created by Ali Aydoğdu on 24.06.2022.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
