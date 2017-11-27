//
//  PagingControl.swift
//  YBTest
//
//  Created by ParaBellum on 11/27/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
protocol PagingControlDelegate:AnyObject {
    func didSelectTab(index:Int)
}

@IBDesignable class PagingControl: UIStackView, PageViewControllerDelegate{
    func didSwipeToVC(at index: Int) {
        selectedTab = index
    }
    
    
    //MARK:Properties
    weak var delegate:PagingControlDelegate?
    
    var labels = ["Все записи","Лучшее","Прямой Эфир"]
    private var tabButtons = [UIButton]()
    var selectedTab = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var tabsCount:Int = 3{
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var buttonSize:CGSize = CGSize(width: 80, height: 40){
        didSet{
            setupButtons()
        }
    }
    
    private let border = CALayer()
    
    //MARK: Initialization
    override init(frame:CGRect){
        super.init(frame: frame)
        self.spacing = 0
        self.distribution = .fillEqually
        self.alignment = .center
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
    
    private func setupButtons(){
        //Set name for border to keep track of it later
        border.name = "Border"
        //If we change IBInspectables in IB - need to redraw all buttons
        for button in tabButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        tabButtons.removeAll()
        
        //Create buttons
        for i in 0..<tabsCount {
            let button = UIButton()
            if labels.count > 0{
                button.setTitle(labels[i], for: .normal)
            }
            button.contentHorizontalAlignment = .center
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.blue, for: .highlighted)
            button.setTitleColor(UIColor.blue, for: .selected)
            button.backgroundColor = UIColor.white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize.height ).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.addTarget(self, action: #selector(PagingControl.tabButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            button.sizeToFit()
            tabButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    //MARK: Button Action
    @objc func tabButtonTapped(button:UIButton){
        guard let index = tabButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the array")
        }
        let tabWereSelected = index
        selectedTab = tabWereSelected
        delegate?.didSelectTab(index: tabWereSelected)
        if tabWereSelected == selectedTab{
            return
        }else{
            selectedTab = tabWereSelected
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in tabButtons.enumerated(){
            button.isSelected = index == selectedTab
            if let sub = button.layer.sublayers{
                for layer in sub{
                    if layer.name == "Border"{
                       
                        
                        layer.removeFromSuperlayer()
                    }
                }
            }
            if button.isSelected{
                //Border
                self.layoutSubviews()
                border.frame = CGRect(x: 0, y: (button.layer.bounds.size.height), width: (button.layer.frame.size.width), height: 2)
                border.backgroundColor = UIColor.blue.cgColor
                let dissapear = CABasicAnimation(keyPath: "transform.scale")
                dissapear.fromValue = 0
                dissapear.toValue = 1
                dissapear.duration = 0.3
                dissapear.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
                dissapear.isRemovedOnCompletion = true
                border.add(dissapear, forKey: nil)
                button.layer.addSublayer(border)
                
                
            }
           
        }
    }
    
}
