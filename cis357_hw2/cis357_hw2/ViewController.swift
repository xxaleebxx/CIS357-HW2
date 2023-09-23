//
//  ViewController.swift
//  cis357_hw2
//
//  Created by Bryan Soriano on 9/23/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var distance:Double = 0.0

    
    func calculateDistance(a:(Double), b:(Double))->Double {
        let result:Double = Double(a-b)
        return (100*result).rounded()/100
    }
    
    
    @IBOutlet weak var latp1: DecimalMinusTextField!
    @IBOutlet weak var latp2: DecimalMinusTextField!
    @IBOutlet weak var longp1: DecimalMinusTextField!
    @IBOutlet weak var longp2: DecimalMinusTextField!
    
    @IBOutlet weak var distanceResult: UILabel!
    
    @IBAction func calcButton(_ sender: Any) {
      latp1 = latp1.text
      latp2 = latp2.text
        distance = calculateDistance(a: latp1, b: latp2)
        distanceResult.text = String(distance)
        print(latp1)
    }
    
    

}

