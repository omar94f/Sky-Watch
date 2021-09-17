//
//  CGRect+Min.swift
//  TheSky
//
//  Created by Omar Farooq on 9/16/21.
//

import UIKit

extension CGRect {
    
    var mininumDimension: CGFloat {
        return min(self.width, self.height)
    }

    var quarterHeight: CGFloat {
        return height/4
    }

    var quarterWidth: CGFloat {
        return width/4
    }

}
