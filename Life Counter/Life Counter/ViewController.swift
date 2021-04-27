//
//  ViewController.swift
//  Life Counter
//
//  Created by Hailun Zhang on 4/22/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var playerLifeLabels: [UILabel]!
    var playerLife: [Int] =
        [20, 20, 20, 20, 20, 20, 20, 20]
    var count:Int = 4
    var history : [String] = []
    var fromHis: String! = nil
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func getHis(_ sender: UIButton) {
        performSegue(withIdentifier: "toHis", sender: self)
    }
    @IBAction func resetPush(_ sender: UIButton) {
        reset()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            var str = ""
            if fromHis != nil {
                str = fromHis
            }
            print(history)
            for item in history {
                str.append(item + "\n")
            }
            vc.incoming = str
        }
    }
    @IBAction func addPlayer(_ sender: Any) {
        count += 1
        if count < 9 {
            switch count {
            case 5:
                view5.isHidden = false
            case 6:
                view6.isHidden = false
            case 7:
                view7.isHidden = false
            case 8:
                view8.isHidden = false
            default:
                break
            }
        } else {
            let controller = UIAlertController(title: "Oops", message: "Cannot add player anymore", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: NSLocalizedString("Got it", comment: "Good to go"), style: .default, handler: {
                _ in NSLog("k")
            }))
            present(controller, animated: true, completion: {NSLog("kk")})
        }
    }
    @IBOutlet weak var loseMessage: UILabel!

    func subUnknown(tag: Int, value: String) {
        playerLife[tag] -= Int(value) ?? 5
        playerLifeLabels[tag].text = String(playerLife[tag])
        checkLose(player: tag)
        history.append("Player \(tag + 1) lost \(value) life.")
    }
    
    func addUnknown(tag: Int, value: String) {
        playerLife[tag - 8] += Int(value) ?? 5
        playerLifeLabels[tag - 8].text = String(playerLife[tag - 8])
        checkLose(player: tag - 8)
        history.append("Player \(tag - 7) gained \(value) life.")
    }
    
    @IBAction func addOne(_ sender: UIButton) {
        playerLife[sender.tag] += 1
        playerLifeLabels[sender.tag].text = String(playerLife[sender.tag])
        checkLose(player: sender.tag)
        history.append("Player \(sender.tag + 1) gained 1 life.")
    }

    @IBAction func subOne(_ sender: UIButton) {
        playerLife[sender.tag] -= 1
        playerLifeLabels[sender.tag].text = String(playerLife[sender.tag])
        checkLose(player: sender.tag)
        history.append("Player \(sender.tag + 1) lost 1 life.")
    }

    
    func checkLose(player: Int) {
        let life = playerLife[player]
        var counter = 0
        if life <= 0 {
            loseMessage.text = "Player \(player + 1) LOSES!"
            history.append("Player \(player + 1) LOSES!")
        }
        if life != 20 {
            addButton.isEnabled = false
        }
        for num in 0..<8 {
            if playerLife[num] <= 0 {
                counter += 1
            }
        }
        if counter == count - 1 {
            reset()
        }
    }
    
    func reset() {
        let controller = UIAlertController(title: "Game Over", message: "Play Next!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Got it", comment: "Good to go"), style: .default, handler: {
            _ in NSLog("k")
        }))
        present(controller, animated: true, completion: {NSLog("kk")})
        playerLife =
            [20, 20, 20, 20, 20, 20, 20, 20]
        count = 4
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view8.isHidden = true
        for num in 0..<8 {
            playerLifeLabels[num].text = String(playerLife[num])
        }
        if !addButton.isEnabled {
            addButton.isEnabled = true
        }
        
        loseMessage.text = "Player X LOSES!"

        history.append("Game reset.")
    }
    
    
    // This function will be called when the textField object( jobTitleTextField ) begin editing.
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("textFieldDidBeginEditing")
        }
        
        // This function is called when you click return key in the text field.
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            print("textFieldShouldReturn")
            if textField.tag <= 7 {
                subUnknown(tag: Int(textField.tag), value: textField.text ?? "5")
                textField.text = "- ?"
            } else {
                addUnknown(tag: Int(textField.tag), value: textField.text ?? "5")
                textField.text = "+ ?"
            }
            
            return true
        }
        
        // This function is called when you input text in the textfield.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            print("textField")
            
            print("input text is : \(string)")
            
            return true
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

            view5.isHidden = true
            view6.isHidden = true
            view7.isHidden = true
            view8.isHidden = true

    }
}

