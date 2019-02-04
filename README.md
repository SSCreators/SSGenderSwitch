# SSGenderSwitch

#ScreenShot

![img_30d88f4df099-1](https://user-images.githubusercontent.com/23047866/52214978-0f2a4500-28b9-11e9-92b8-2eaa8823c3fb.jpeg)


# Usage

You can create the view through code or InterfaceBuilder

        var switchView                                : SSGenderSwitch!
        switchView = SSGenderSwitch.init()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.backgroundColor = .clear
        switchView.delegate = self
        self.view.addSubview(switchView)
        
        
        //Constrain
        
        let layout : SSEasyLayout = SSEasyLayout.init(layoutType: SSEasyLayoutTypeDefault)
        
        layout.constraint(withItem: switchView, marginConstraintsWithEdgeInset: UIEdgeInsets(top: SSEasyLayoutNoValue, left:    20, bottom: SSEasyLayoutNoValue, right: 20))
        layout.constraint(withItemCenter: switchView, toItem: self.view)
        layout.constraint(withItem: switchView, heightForView: 120)
        
        layout.activeAllConstraints()


# Delegate

    func didSelectGender(_ isMale: Bool) {
        
        print(isMale ? "Male " : "Female")
    }
