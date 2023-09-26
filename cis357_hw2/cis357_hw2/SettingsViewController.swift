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

class SettingsViewController: UIViewController {
    
    var pickerData: [String] = [String]()
    var distanceUnits: String = ""
    var bearingUnits: String = ""
    var delegate : SettingsViewControllerDelegate?
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: distanceUnits, bearingUnits: bearingUnits)
        }
    }
    
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var bearingText: UILabel!
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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


