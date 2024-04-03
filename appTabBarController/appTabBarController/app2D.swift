//
//  ViewController.swift
//  appGraficos2DEnUnUIView
//
//  Created by Michael Steve Espinoza Perez on 18/05/23.
//

import UIKit
class app2D: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var canvas: Graficos2D!
    @IBOutlet weak var labelAncho: UILabel!
    @IBOutlet weak var labelAlto: UILabel!
    @IBOutlet weak var texto1: UITextField!
    @IBOutlet weak var texto2: UITextField!
    @IBOutlet weak var texto3: UITextField!
    @IBOutlet weak var texto4: UITextField!
    @IBOutlet weak var textoPC1X: UITextField!
    @IBOutlet weak var textoPC1y: UITextField!
    @IBOutlet weak var textoPC2X: UITextField!
    @IBOutlet weak var textoPC2y: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        slider.minimumValue = 0.0
               slider.maximumValue = 1.0
               slider.value = 0.5
               slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

               // Configurar la vista de accesorios del teclado para los campos de texto
               texto1.inputAccessoryView = createDoneToolbar()
               texto2.inputAccessoryView = createDoneToolbar()
               texto3.inputAccessoryView = createDoneToolbar()
               texto4.inputAccessoryView = createDoneToolbar()
               textoPC1X.inputAccessoryView = createDoneToolbar()
               textoPC1y.inputAccessoryView = createDoneToolbar()
               textoPC2X.inputAccessoryView = createDoneToolbar()
               textoPC2y.inputAccessoryView = createDoneToolbar()
      }
    
    func createDoneToolbar() -> UIToolbar {
          let toolbar = UIToolbar()
          toolbar.sizeToFit()

          let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

          toolbar.items = [flexibleSpace, doneButton]

          return toolbar
      }

      @objc func doneButtonTapped() {
          view.endEditing(true) // Ocultar el teclado
      }
    
    @IBAction func botonDibujar(_ sender: UIButton) {
        guard let text1 = texto1.text, let text2 = texto2.text, let text3 = texto3.text, let text4 = texto4.text else {
            showAlert(message: "Debe ingresar todos los valores")
            return
        }
        
        guard let x1 = Int(text1), let y1 = Int(text2), let x2 = Int(text3), let y2 = Int(text4) else {
            showAlert(message: "Los valores ingresados no son válidos")
            return
        }
        
        canvas.x1 = x1
        canvas.y1 = y1
        canvas.x2 = x2
        canvas.y2 = y2
        
        canvas.setNeedsDisplay()
    }
    
    @IBAction func botonAnchoAlto(_ sender: UIButton) {
        labelAncho.text = "Ancho: \(canvas.bounds.width)"
        labelAlto.text = "Alto: \(canvas.bounds.height)"
    }
    
    @IBAction func botonQuadratica(_ sender: UIButton) {
        guard let pc1XText = textoPC1X.text, let pc1YText = textoPC1y.text, let pc2XText = textoPC2X.text, let pc2YText = textoPC2y.text else {
            showAlert(message: "Debe ingresar todos los valores")
            return
        }
        
        guard let pc1X = Int(pc1XText), let pc1Y = Int(pc1YText), let pc2X = Int(pc2XText), let pc2Y = Int(pc2YText) else {
            showAlert(message: "Ingrese valores porfavor")
            return
        }
        
        canvas.pcx1 = pc1X
        canvas.pcy1 = pc1Y
        canvas.pcx2 = pc2X
        canvas.pcy2 = pc2Y
        
        canvas.setNeedsDisplay()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
            canvas.sliderValue = CGFloat(sender.value)
            canvas.setNeedsDisplay()
        }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

