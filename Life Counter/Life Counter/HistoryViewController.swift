//
//  HistoryViewController.swift
//  Life Counter
//
//  Created by Hailun Zhang on 4/28/21.
//

import UIKit

class HistoryViewController:
    UIViewController {
    @IBOutlet weak var showHis: UILabel!
    public var incoming: String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if incoming != nil {
            self.showHis.text = incoming
        }
    }
}
