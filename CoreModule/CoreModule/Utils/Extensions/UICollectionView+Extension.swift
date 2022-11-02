//
//  UICollectionView+Extension.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func dequeueReusableCell<T: CellConfigurable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell")
        }

        return cell
    }
}
