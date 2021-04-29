//
//  ViewController.swift
//  Life Counter
//
//  Created by Hailun Zhang on 4/22/21.
//

import UIKit

var history : [String] = []
var lost : [Bool] = [false, false, false, false, false, false, false, false]
var count:Int = 4
var reset:Int = 0
var start: Bool = false

protocol MyViewDelegate {
    func reset()
    func showMessage(str : String)
    func disableButton()
}

class ViewController: UIViewController, UITextFieldDelegate, MyViewDelegate {
    func disableButton() {
        addButton.isEnabled = false
    }
    
    func showMessage(str: String) {
        loseMessage.text = str
    }
    
    
        
    @IBOutlet weak var Panel: UIStackView!
    var playerLife: [Int] =
        [20, 20, 20, 20, 20, 20, 20, 20]
    var count:Int = 4
    var fromHis: String! = nil
    
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
            for item in history {
                str.append(item + "\n")
            }
            vc.incoming = str
        }
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        count += 1
        if count < 9 {
            let playerPanel = PlayerView()
            playerPanel.data = (count, 20)
            playerPanel.delegate = self
            Panel.addArrangedSubview(playerPanel)
        } else {
            let controller = UIAlertController(title: "Oops", message: "Cannot add player anymore", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: NSLocalizedString("Got it", comment: "Good to go"), style: .default, handler: {
                _ in NSLog("k")
            }))
            present(controller, animated: true, completion: {NSLog("kk")})
        }
    }
    
    @IBOutlet weak var loseMessage: UILabel!
    
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
        let someVC = ViewController()
        self.navigationController?.pushViewController(someVC, animated: true)
        let controller = UIAlertController(title: "Game Over", message: "Play Next!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Got it", comment: "Good to go"), style: .default, handler: {
            _ in NSLog("k")
        }))
        present(controller, animated: true, completion: {NSLog("kk")})
        playerLife =
            [20, 20, 20, 20, 20, 20, 20, 20]
        count = 0
        while count < 4 {
            count += 1
            let playerPanel = PlayerView()
            playerPanel.data = (count, 20)
            playerPanel.delegate = self
            Panel.addArrangedSubview(playerPanel)
        }
        if !addButton.isEnabled {
            addButton.isEnabled = true
        }
        
        loseMessage.text = "Player X LOSES!"

        history.append("Game reset.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        count = 0
        while count < 4 {
            count += 1
            let playerPanel = PlayerView()
            playerPanel.data = (count, 20)
            playerPanel.delegate = self
            Panel.addArrangedSubview(playerPanel)
        }

    }
}

class PlayerView: UIView, UITextFieldDelegate {
    var delegate: MyViewDelegate?

    var data : (Int, Int) = (0, 20) {
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
        print(nibView)
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
    
    
    @objc private func subUnknown(value: String) {
        data.1 -= Int(value) ?? 5
        playerLife.text = "\(data.1)"
        checkLose()
        history.append("Player \(data.0) lost \(value) life.")
        delegate?.disableButton()
    }
    
    @objc private func addUnknown(value: String) {
        data.1 += Int(value) ?? 5
        playerLife.text = "\(data.1)"
        checkLose()
        history.append("Player \(data.0) gained \(value) life.")
        delegate?.disableButton()
    }
    
    @objc private func addOne(_ sender: UIButton) {
        data.1 += 1
        playerLife.text = "\(data.1)"
        checkLose()
        history.append("Player \(data.0) gained 1 life.")
        delegate?.disableButton()
    }

    @objc private func subOne(_ sender: UIButton) {
        data.1 -= 1
        playerLife.text = "\(data.1)"
        checkLose()
        history.append("Player \(data.0) lost 1 life.")
        delegate?.disableButton()
    }
        
        // This function is called when you input text in the textfield.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }
    
    func checkLose() {
        if data.1 <= 0 {
            print(1)
            lost[data.0 - 1] = true
            history.append("Player \(data.0) LOSES!")
            delegate?.showMessage(str: "Player \(data.0) LOSES!")
        }
        var c = 0
        for i in 0..<8 {
            if lost[i] {
                c += 1
            }
        }
        if c == count - 1 {
            delegate?.reset()
        }
    }
    
}
