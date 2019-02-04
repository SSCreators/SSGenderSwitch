# SSGenderSwitch

#ScreenShot

![ssgender](https://user-images.githubusercontent.com/23047866/52215388-f4a49b80-28b9-11e9-9829-f20a681e7d1d.gif)




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
