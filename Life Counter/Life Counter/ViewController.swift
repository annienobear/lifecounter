//
//  ViewController.swift
//  Life Counter
//
//  Created by Hailun Zhang on 4/22/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lostMessage: UILabel!
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    @IBOutlet weak var playerThree: UILabel!
    @IBOutlet weak var playerFour: UILabel!
    var playerOneLife : Int = 10
    var playerTwoLife : Int = 10
    var playerThreeLife : Int = 10
    var playerFourLife : Int = 10
    
    @IBAction func addOne(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 0:
            playerOneLife += 1
            print(playerOneLife)
            playerOne.text = String(playerOneLife)
        case 1:
            playerTwoLife += 1
            playerTwo.text = String(playerTwoLife)
        case 2:
            playerThreeLife += 1
            playerThree.text = String(playerThreeLife)
        case 3:
            playerFourLife += 1
            playerFour.text = String(playerFourLife)
        default:
            break
        }
        checkLose()
    }
    
    @IBAction func addFive(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            playerOneLife += 5
            playerOne.text = String(playerOneLife)
        case 1:
            playerTwoLife += 5
            playerTwo.text = String(playerTwoLife)
        case 2:
            playerThreeLife += 5
            playerThree.text = String(playerThreeLife)
        case 3:
            playerFourLife += 5
            playerFour.text = String(playerFourLife)
        default:
            break
        }
        checkLose()
    }
    
    @IBAction func subtractOne(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            playerOneLife -= 1
            print(playerOneLife)
            playerOne.text = String(playerOneLife)
        case 1:
            playerTwoLife -= 1
            playerTwo.text = String(playerTwoLife)
        case 2:
            playerThreeLife -= 1
            playerThree.text = String(playerThreeLife)
        case 3:
            playerFourLife -= 1
            playerFour.text = String(playerFourLife)
        default:
            break
        }
        checkLose()
    }
    
    @IBAction func subtractFive(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            playerOneLife -= 5
            print(playerOneLife)
            playerOne.text = String(playerOneLife)
        case 1:
            playerTwoLife -= 5
            playerTwo.text = String(playerTwoLife)
        case 2:
            playerThreeLife -= 5
            playerThree.text = String(playerThreeLife)
        case 3:
            playerFourLife -= 5
            playerFour.text = String(playerFourLife)
        default:
            break
        }
        checkLose()
    }
    
    func checkLose() {
        var flag: Bool = false
        if playerOneLife <= 0 {
            flag = true
            lostMessage.text = "Player One LOSES!"
        } else if playerTwoLife <= 0 {
            flag = true
            lostMessage.text = "Player Two LOSES!"
        } else if playerThreeLife <= 0 {
            flag = true
            lostMessage.text = "Player Three LOSES!"
        } else if playerFourLife <= 0 {
            flag = true
            lostMessage.text = "Player Four LOSES!"
        }
        if flag {
            lostMessage.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lostMessage.isHidden = true
    }
}

