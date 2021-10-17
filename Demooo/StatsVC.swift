//
//  StatsVC.swift
//  Demooo
//
//  Created by Evelyn Hu on 10/3/21.
//

import Foundation
import UIKit

protocol StatsVCDelegate: AnyObject{
    
    func statsVC(_ vc: StatsVC, didTapReset: Bool)
}

class StatsVC: UIViewController{
    var delegate: StatsVCDelegate?
}
