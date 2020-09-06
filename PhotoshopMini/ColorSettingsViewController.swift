//
//  ViewController.swift
//  PhotoshopMini
//
//  Created by Vladimir on 22/08/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit

class ColorSettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var previewColorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var delegate: ColorSettingsViewControlerDelegate!
    var mainViewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        previewColorView.layer.cornerRadius = 10
        
        setSlidersValue(isTextFieldEdited: false)
        setLabelsValue()
        setTextFieldsValue()
        changeColorOfPreviewView()

        addedDoneButtonForKeyboard()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        setLabelsValue(slider: sender)
        setTextFieldsValue(slider: sender)
        changeColorOfPreviewView()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setBackgroundColorForView(previewColorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
    private func changeColorOfPreviewView() {
        previewColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: previewColorView.alpha
        )
    }
    
    private func setTextFieldsValue(slider: UISlider? = nil) {
        guard let slider = slider else {
            redTextField.text = string(from: redSlider)
            greenTextField.text = string(from: greenSlider)
            blueTextField.text = string(from: blueSlider)
            return
        }
        switch slider.tag {
        case CurrentColor.red.rawValue:
            redTextField.text = string(from: redSlider)
        case CurrentColor.green.rawValue:
            greenTextField.text = string(from: greenSlider)
        case CurrentColor.blue.rawValue:
            blueTextField.text = string(from: blueSlider)
        default:
            return
        }
    }
    
    private func setLabelsValue(slider: UISlider? = nil) {
        guard let slider = slider else {
            redLabel.text = string(from: redSlider)
            greenLabel.text = string(from: greenSlider)
            blueLabel.text = string(from: blueSlider)
            return
        }
        switch slider.tag {
        case CurrentColor.red.rawValue:
            redLabel.text = string(from: redSlider)
        case CurrentColor.green.rawValue:
            greenLabel.text = string(from: greenSlider)
        case CurrentColor.blue.rawValue:
            blueLabel.text = string(from: blueSlider)
        default:
            return
        }
    }
    
    private func addedDoneButtonForKeyboard() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                         action: #selector(self.doneButtonKeyboardPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
    @objc private func doneButtonKeyboardPressed() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setSlidersValue(isTextFieldEdited: true, textField: textField)
        changeColorOfPreviewView()
    }
    
    private func setSlidersValue(isTextFieldEdited: Bool, textField: UITextField? = nil) {
        if isTextFieldEdited {
            switch textField?.tag {
            case CurrentColor.red.rawValue:
                guard let redColor = redTextField.text else { return }
                guard let red = Float(redColor) else { return }
                redSlider.value =  red
                setLabelsValue(slider: redSlider)
            case CurrentColor.green.rawValue:
                guard let greenColor = greenTextField.text else { return }
                guard let green = Float(greenColor) else { return }
                greenSlider.value =  green
                setLabelsValue(slider: greenSlider)
            case CurrentColor.blue.rawValue:
                guard let blueColor = blueTextField.text else { return }
                guard let blue = Float(blueColor) else { return }
                blueSlider.value =  blue
                setLabelsValue(slider: blueSlider)
            default:
                return
            }
        } else {
            redSlider.value = Float(CIColor(color: mainViewColor).red)
            greenSlider.value = Float(CIColor(color: mainViewColor).green)
            blueSlider.value = Float(CIColor(color: mainViewColor).blue)
        }
    }
    
    //Value RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

//MARK: Extensions
extension ColorSettingsViewController {
    private enum CurrentColor: Int {
        case red, green, blue
    }
}
