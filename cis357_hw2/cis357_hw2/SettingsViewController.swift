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
    
    var originalDistanceText:String = ""
    var originalBearingText:String = ""
    
    var saveDistanceText: String = ""
    var saveBearingText: String = ""
    
    var selectedDistanceRow = 0
    var selectedBearingRow = 0

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
        
        selectedDistanceRow = picker.selectedRow(inComponent: 0)
        selectedBearingRow = picker.selectedRow(inComponent: 0)
        
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
        

        let distanceTapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        distanceText.isUserInteractionEnabled = true
        distanceText.addGestureRecognizer(distanceTapGesture)
        let bearingTapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        bearingText.isUserInteractionEnabled = true
        bearingText.addGestureRecognizer(bearingTapGesture)
        
        originalDistanceText = distanceText.text!
        originalBearingText = bearingText.text!
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOutside(_:)))
            view.addGestureRecognizer(tapGestureRecognizer)
    
            
        }
    
    @IBAction func cancelButton(_ sender: Any) {
        distanceText.text = originalDistanceText
        bearingText.text = originalBearingText

        self.navigationController?.dismiss(animated: true)
    }
    
    
    
    @objc func tapOutside(_ sender: UITapGestureRecognizer) {
        let tap = sender.location(in: view)
        
        if !picker.frame.contains(tap) && !distanceText.frame.contains(tap) && !bearingText.frame.contains(tap) {
            picker.isHidden = true
        }
    }

    
    
    //There is an issue where if you change the distanceText to miles(2nd field in picker), and then click on the bearingText, it auto updates it to the 2nd field in picker.
    @objc func tap(_ text: UITapGestureRecognizer) {

            if text.view == distanceText {
                self.pickerData = ["Kilometers", "Miles"]
                let selected = picker.selectedRow(inComponent: 0)
                distanceText.text = pickerData[selected]
                picker.selectRow(selectedDistanceRow, inComponent: 0, animated: true)
                saveDistanceText = pickerData[selected]
            }
            else if text.view == bearingText {
                self.pickerData = ["Degrees", "Mils"]
                let selected = picker.selectedRow(inComponent: 0)
                bearingText.text = pickerData[selected]
                picker.selectRow(selectedBearingRow, inComponent: 0, animated: true)
                saveBearingText = pickerData[selected]
            }
        
        
            picker.reloadAllComponents()
            
            if picker.isHidden {
                picker.isHidden = false
            }
            else {
                picker.isHidden = true
            }

        }
    
    
    //SAVE DOES NOT WORK, WHEN YOU OPEN IT AFTER SAVING, PREVIOUS VALUE NOT STORED
    @IBAction func saveButton(_ sender: Any) {
        print(distanceText.text)
        saveDistanceText = distanceText.text ?? ""
        saveBearingText = bearingText.text ?? ""
        delegate?.settingsChanged(distanceUnits: distanceUnits, bearingUnits: bearingUnits)
        self.navigationController?.dismiss(animated: true)
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


