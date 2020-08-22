//
//  ViewController.swift
//  PhotoshopMini
//
//  Created by Vladimir on 22/08/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previewColorView: UIView!
    
    @IBOutlet weak var valueOfRedLabel: UILabel!
    @IBOutlet weak var valueOfGreenLabel: UILabel!
    @IBOutlet weak var valueOfBlueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    private let cornerRadius: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewColorView.layer.cornerRadius = cornerRadius
        
        changeValueOfColorLabels()
        changeColorOfPrevirewView()
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        changeValueOfColorLabels(slider: sender)
        changeColorOfPrevirewView()
        
    }

    private func changeColorOfPrevirewView() {
        previewColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: previewColorView.alpha
        )
    }
    
    private func changeValueOfColorLabels(slider: UISlider? = nil) {
        guard let slider = slider else {
            valueOfRedLabel.text = String(format: "%.2F", redSlider.value)
            valueOfGreenLabel.text = String(format: "%.2F", greenSlider.value)
            valueOfBlueLabel.text = String(format: "%.2F",blueSlider.value)
            return
        }
        /*Тут я не знаю как лучше было поступить. Можно было сделать без параметров
        и всегда менять всем label значения как в guard или в итоге делать проверку,
        
         */
        switch slider.tag {
        case CurrentColor.red.rawValue:
            valueOfRedLabel.text = String(format: "%.2F", redSlider.value)
        case CurrentColor.green.rawValue:
            valueOfGreenLabel.text = String(format: "%.2F", greenSlider.value)
        case CurrentColor.blue.rawValue:
            valueOfBlueLabel.text = String(format: "%.2F",blueSlider.value)
        default:
            return
        }
    }
}

//MARK: Extensions
extension ViewController {
    private enum CurrentColor: Int {
        case red, green, blue
    }
}
