//
//  ItemCellSelectable.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 27/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol CollectionViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
    func loadMore()
}
