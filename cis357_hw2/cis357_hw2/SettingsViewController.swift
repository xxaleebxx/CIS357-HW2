//
//  SettingsViewController.swift
//  cis357_hw2
//
//  Created by Bryan Soriano and Autumn Bertram on 9/24/23.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var bearingText: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var distanceUnits: String = ""
    var bearingUnits: String = ""
    var delegate : SettingsViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self

        // Do any additional setup after loading the view.
        if picker.tag == 0 {
            self.pickerData = ["Kilometers", "Miles"]
        }
        else if picker.tag == 1 {
            self.pickerData = ["Degrees", "Mils"]
        }
        self.picker.delegate = self
        self.picker.dataSource = self
        
        if self.picker.tag == 1 {
            if let index = pickerData.firstIndex(of: self.bearingUnits){
                self.picker.selectRow(index, inComponent: 0, animated: true)
            }
        }
        else if self.picker.tag == 0 {
            if let index = pickerData.firstIndex(of: self.distanceUnits) {
                self.picker.selectRow(index, inComponent: 0, animated: true)
            }
        }
        else {
            self.picker.selectRow(0, inComponent: 0, animated: true)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        distanceText.isUserInteractionEnabled = true
        distanceText.addGestureRecognizer(tapGesture)
        bearingText.isUserInteractionEnabled = true
        bearingText.addGestureRecognizer(tapGesture)
            
        }
    
    @objc func tap() {
        if picker.isHidden {
            picker.isHidden = false
        }
        else {
                picker.isHidden = true
            }
        }
    
    
    
    }


    

    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.picker.tag == 0 {
            self.distanceUnits = self.pickerData[row]
        }
        else if self.picker.tag == 1 {
            self.bearingUnits = self.pickerData[row]
        }
    }
    
    
    
}


