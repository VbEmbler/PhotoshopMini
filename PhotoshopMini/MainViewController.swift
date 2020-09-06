//
//  MainViewController.swift
//  PhotoshopMini
//
//  Created by Vladimir on 06/09/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit

protocol ColorSettingsViewControlerDelegate {
    func setBackgroundColorForView(_ backgroundColor: UIColor)
}

class MainViewController: UIViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showColorSettings" {
            guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
            colorSettingsVC.mainViewColor = view.backgroundColor
            colorSettingsVC.delegate = self
        }
    }
}

extension MainViewController: ColorSettingsViewControlerDelegate {
    func setBackgroundColorForView(_ backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
    }
}
