//
//  UIImage+Extension.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 26/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Kingfisher
import UIKit

public extension UIImageView {
    func downloadImage(from url: URL, placeHolder: UIImage) {
        KF.url(url)
            .showActivityIndicator(self)
            .cacheMemoryOnly()
            .fade(duration: 0.1)
            .onProgress { _, _ in
                self.kf.indicatorType = .activity
            }
            .onSuccess { _ in
                self.kf.indicatorType = .none
            }
            .set(to: self)
    }
}

private extension KF.Builder {
    func showActivityIndicator(_ image: UIImageView) -> Self {
        image.kf.indicatorType = .activity
        return self
    }
}
