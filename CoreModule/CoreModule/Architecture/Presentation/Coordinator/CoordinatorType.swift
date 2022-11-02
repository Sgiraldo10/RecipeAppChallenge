//
//  CoordinatorType.swift
//  
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

public protocol CoordinatorType: AnyObject {
    func start()
    func childDeinitialized(_ child: CoordinatorType)
}
