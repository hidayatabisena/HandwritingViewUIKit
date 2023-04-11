//
//  ViewController.swift
//  HandwritingView
//
//  Created by Hidayat Abisena on 11/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var handwritingView: HandwritingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func colorButtonTapped(_ sender: Any) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        handwritingView.clear()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let handwritingImage = handwritingView.getHandwritingImage() else { return }
        UIImageWriteToSavedPhotosAlbum(handwritingImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image successfully saved")
        }
    }
    
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        handwritingView.setStrokeColor(selectedColor)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

