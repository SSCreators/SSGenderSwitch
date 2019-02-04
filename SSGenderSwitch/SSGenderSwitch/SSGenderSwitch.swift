//
//  GGGenderSwitch.swift
//  Gograb Unity
//
//  Created by Victor Sebastian on 1/31/19.
//

import Foundation
import UIKit
import SSEasyLayout


protocol SSGenderDelegate {
    func didSelectGender(_ isMale:Bool)
}

public class SSGenderSwitch: UIView
{

    var switchView                 : UIButton!
    var selectionView              : UIButton!
    let switchViewHeight           = CGFloat(66)
    var switchLeading              = CGFloat(0)
    public var isMaleGender        = true
    var maleImgView                : UIImageView!
    var femaleImgView              : UIImageView!
    var maleLbl                    : UILabel!
    var FemaleLbl                  : UILabel!
    var delegate                   : SSGenderDelegate?
    
    
    convenience init()
    {
        self.init(frame: .zero)
        
        setupFields()
        setupConstraints()
    }
    
    private func setupFields()
    {
        
        //        switchView
        
        switchView = UIButton.init()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.layer.masksToBounds = true
        switchView.layer.cornerRadius = switchViewHeight/2
        switchView.backgroundColor = .white
        switchView.addTarget(self, action: #selector(genderClickAction), for: UIControl.Event.touchUpInside)
        self.addSubview(switchView)
        
        
        //        maleImgView
        
        maleImgView = UIImageView.init()
        maleImgView.translatesAutoresizingMaskIntoConstraints = false
        maleImgView.layer.masksToBounds = true
        maleImgView.contentMode = .center
        maleImgView.image = UIImage.init(named: "mars")
        maleImgView.tintColor = UIColor.white
        switchView.addSubview(maleImgView)
        
        
        //        femaleImgView
        
        femaleImgView = UIImageView.init()
        femaleImgView.translatesAutoresizingMaskIntoConstraints = false
        femaleImgView.layer.masksToBounds = true
        femaleImgView.contentMode = .center
        femaleImgView.image = UIImage.init(named: "venus")
        femaleImgView.tintColor = UIColor.white
        switchView.addSubview(femaleImgView)
        
        
//        maleLbl
        
        maleLbl = UILabel.init()
        maleLbl.translatesAutoresizingMaskIntoConstraints = false
        maleLbl.font = UIFont.systemFont(ofSize: 12)
        maleLbl.textColor = .black
        maleLbl.textAlignment = .center
        maleLbl.text = "Male"
        self.addSubview(maleLbl)

        
//        FemaleLbl

        FemaleLbl = UILabel.init()
        FemaleLbl.translatesAutoresizingMaskIntoConstraints = false
        FemaleLbl.font = UIFont.systemFont(ofSize: 12)
        FemaleLbl.textColor = .black
        FemaleLbl.textAlignment = .center
        FemaleLbl.text = "Female"
        self.addSubview(FemaleLbl)
        
        
        //        selectionView
        
        
        selectionView = UIButton.init()
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.layer.masksToBounds = true
        selectionView.layer.cornerRadius = switchViewHeight/2
        selectionView.setImage(maleImgView.image,   for: .normal)
        selectionView.setImage(femaleImgView.image, for: .selected)
        selectionView.imageView?.contentMode = .center
        selectionView.tintColor = .white
        selectionView.isUserInteractionEnabled = false
        selectionView.backgroundColor = .black
        switchView.addSubview(selectionView)
        
        
        
    }
    
    
    private func setupConstraints()
    {
        
        
        
        let layout : SSEasyLayout = SSEasyLayout.init(layoutType: SSEasyLayoutTypeCustomInverse)
        
//        switchView
        
        layout.constraint(withItemSuperViewCenter: switchView)
        layout.constraint(withItem: switchView, equalHeightAndWidthSizeForView: .init(width: switchViewHeight*2, height: switchViewHeight))
        
//        selectionView
        
        layout.constraint(withItem: selectionView, marginConstraintsWithEdgeInset: UIEdgeInsets(top: 0, left: SSEasyLayoutNoValue, bottom: 0, right: SSEasyLayoutNoValue))
        layout.constraint(withItem: selectionView, equalToSuperViewAttribute: .leading, constant: 0)
        layout.constraint(withItem: selectionView, equalHeightAndWidthSizeForView: .init(width: switchViewHeight, height: switchViewHeight))
        
//        maleImgView
        
        layout.constraint(withItem: maleImgView, marginConstraintsWithEdgeInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SSEasyLayoutNoValue))
        layout.constraint(withItem: maleImgView, widthForView: switchViewHeight)
        
//        femaleImgView
        
        layout.constraint(withItem: femaleImgView, marginConstraintsWithEdgeInset: UIEdgeInsets(top: 0, left: SSEasyLayoutNoValue, bottom: 0, right: 0))
        layout.constraint(withItem: femaleImgView, widthForView: switchViewHeight)
        
        //        maleLbl
        
        layout.constraint(withItem: maleLbl, attribute: .top, toItem: switchView, attribute: .bottom, constant:5)
        layout.constraint(withItem: maleLbl, attribute: .leading, toItem: switchView, attribute: .leading, constant:0)
        layout.constraint(withItem: maleLbl, widthForView: switchViewHeight)
        
        //        FemaleLbl
        
        layout.constraint(withItem: FemaleLbl, attribute: .top, toItem: switchView, attribute: .bottom, constant:5)
        layout.constraint(withItem: FemaleLbl, attribute: .trailing, toItem: switchView, attribute: .trailing, constant:0)
        layout.constraint(withItem: FemaleLbl, widthForView: switchViewHeight)
        
        layout.activeAllConstraints()
        
    }
    
    @objc func genderClickAction(){
    
        if (isMaleGender)
        {
            isMaleGender                    =  false
            switchLeading                   =  switchViewHeight
            maleImgView.tintColor           = .gray
            femaleImgView.tintColor         = .white
            maleLbl.textColor               = .gray
            FemaleLbl.textColor             = .black
            selectionView.isSelected        = true
            
        }else
        {
            isMaleGender                    =  true
            switchLeading                   =  0
            maleImgView.tintColor           = .white
            femaleImgView.tintColor         = .gray
            maleLbl.textColor               = .black
            FemaleLbl.textColor             = .gray
            selectionView.isSelected        = false
        }
        
        if delegate != nil {
            delegate?.didSelectGender(isMaleGender)
        }
        
        SSEasyLayout.changeConstraintValue(forView: selectionView, attribute: .leading, constant: Float(switchLeading))
        
        //Layout change with animation
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }


}
