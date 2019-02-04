//
//  ViewController.swift
//  SSGenderSwitch
//
//  Created by Victor Sebastian on 2/4/19.
//  Copyright © 2019 Victor Sebastian. All rights reserved.
//

import UIKit
import SSEasyLayout

class ViewController: UIViewController,SSGenderDelegate {

    var switchView                                : SSGenderSwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        //        switchView
        
        switchView = SSGenderSwitch.init()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.backgroundColor = .clear
        switchView.delegate = self
        self.view.addSubview(switchView)
        
        
        //Constrain
        
        let layout : SSEasyLayout = SSEasyLayout.init(layoutType: SSEasyLayoutTypeDefault)
        
        layout.constraint(withItem: switchView, marginConstraintsWithEdgeInset: UIEdgeInsets(top: SSEasyLayoutNoValue, left: 20, bottom: SSEasyLayoutNoValue, right: 20))
        layout.constraint(withItemCenter: switchView, toItem: self.view)
        layout.constraint(withItem: switchView, heightForView: 120)
        
        layout.activeAllConstraints()
    }

    
    func didSelectGender(_ isMale: Bool) {
        
        print(isMale ? "Male " : "Female")
    }


}

