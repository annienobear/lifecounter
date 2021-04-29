//
//  PlayerViewController.swift
//  Life Counter
//
//  Created by Hailun Zhang on 4/29/21.
//

import UIKit

class PlayerView: UIView, UITextFieldDelegate {

    var data : (Int, Int, [String], Bool) = (0, 20, [], false) {
        didSet {
            // Update the label with modified data
            playerLabel.text = "Player \(data.0): "
            playerLife.text = "\(data.1)"
        }
    }
    
    weak var playerLabel : UILabel!
    weak var playerLife : UILabel!
    weak var subCustom : UITextField!
    weak var addCustom : UITextField!
    weak var subOne : UIButton!
    weak var addOne : UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    private func initSubViews() {
        // Instantiate the nib into existence
        let nib = UINib(nibName: "PlayerViewController", bundle: nil)
        let nibInstance = nib.instantiate(withOwner: self, options: nil)
        
        // Get the view from the instantiated nib and add it into our own tree
        let nibView = (nibInstance.first) as! UIView
        addSubview(nibView)
        
        playerLabel = (nibView.subviews[0].subviews[0].subviews[0] as! UILabel)
        playerLabel.text = "Player \(data.0): "
        playerLife = (nibView.subviews[0].subviews[0].subviews[1] as! UILabel)
        playerLife.text = "\(data.1)"
        subCustom = (nibView.subviews[0].subviews[1].subviews[0].subviews[1] as! UITextField)
        subCustom.tag = data.0 - 1
        subCustom.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        addCustom = (nibView.subviews[0].subviews[1].subviews[3].subviews[1] as! UITextField)
        addCustom.tag = data.0 - 1 + 8
        addCustom.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        subOne = (nibView.subviews[0].subviews[1].subviews[1] as! UIButton)
        subOne.addTarget(self, action: #selector(subOne(_:)), for: .touchUpInside)
        addOne = (nibView.subviews[0].subviews[1].subviews[2] as! UIButton)
        addOne.addTarget(self, action: #selector(addOne(_:)), for: .touchUpInside)
        
        // Wire up the controls to this view

//
//        button = (nibView.subviews[0].subviews[1] as! UIButton)
//        button.addTarget(self, action: #selector(happyBirthdayPushed(_:)), for: .touchUpInside)
    }
    
    // This function will be called when the textField object( jobTitleTextField ) begin editing.
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("textFieldDidBeginEditing")
        }
        
        // This function is called when you click return key in the text field.
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.tag <= 7 {
                subUnknown(value: textField.text ?? "5")
                textField.text = ""
            } else {
                addUnknown(value: textField.text ?? "5")
                textField.text = ""
            }
            return true
        }
    
    
    @objc func subUnknown(value: String) {
        data.1 -= Int(value) ?? 5
        playerLife.text = "\(data.1)"
//        checkLose(player: tag)
        data.2.append("Player \(data.0) lost \(value) life.")
    }
    
    @objc func addUnknown(value: String) {
        data.1 += Int(value) ?? 5
        playerLife.text = "\(data.1)"
//        checkLose(player: tag - 8)
        data.2.append("Player \(data.0) gained \(value) life.")
    }
    
    @IBAction func addOne(_ sender: UIButton) {
        data.1 += 1
        playerLife.text = "\(data.1)"
//        checkLose(player: sender.tag)
        data.2.append("Player \(data.0) gained 1 life.")
    }

    @IBAction func subOne(_ sender: UIButton) {
        data.1 -= 1
        playerLife.text = "\(data.1)"
//        checkLose(player: sender.tag)
        data.2.append("Player \(data.0) lost 1 life.")
    }

        
        // This function is called when you input text in the textfield.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }
    
    func checkLose() {
        if data.1 <= 0 {
            data = (data.0, data.1, data.2, true)
        }
    }
}
