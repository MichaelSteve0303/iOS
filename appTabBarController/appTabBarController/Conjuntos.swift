//  ViewController.swift
//  appConjuntosIOS
//
//  Created by Michael Steve Espinoza Perez on 11/05/23.
//

import UIKit

class Conjuntos: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {


    var setA = Set<String>()
    var setB = Set<String>()
    @IBOutlet weak var textoConjuntoA: UITextField!
    @IBOutlet weak var textoConjuntoB: UITextField!
    @IBOutlet weak var labelResultado: UILabel!
    @IBOutlet weak var botonAsignarSetA: UIButton!
    @IBOutlet weak var botonAsignarSetB: UIButton!
    @IBOutlet weak var botonUnion: UIButton!
    @IBOutlet weak var botonInterseccion: UIButton!
    @IBOutlet weak var botonDiferencia: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let positiveMessages = [
         "¡Eres increíble!",
         "Hoy será un gran día.",
         "Tienes un talento especial.",
         "Eres valiente y fuerte.",
         "Tu sonrisa ilumina el mundo.",
         "Si quieres saber mas sobre esta app.",
         "Escribeme",
         "michael_jr_ea@hotmail.com",
         "Clase de IOS",
         "Clase del OSWi"
     ]

    var currentIndex = 0    // HASTA AQUI COMIENZA UNA APP INCREIBLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Variables nuevas//
        
        textoConjuntoA.delegate = self
        textoConjuntoB.delegate = self
        // hasta aaqui...
        
        // Inicia el temporizador para mostrar mensajes positivos cada 10 segundos
        perform(#selector(showNextPositiveMessage), with: nil, afterDelay: 10)

    }
    
    @objc func showNextPositiveMessage() {
            if currentIndex < positiveMessages.count {
                let message = positiveMessages[currentIndex]
                textView.text = message

                currentIndex = (currentIndex + 1) % positiveMessages.count

                perform(#selector(showNextPositiveMessage), with: nil, afterDelay: 4)
            }
        }

    @IBAction func botonUnion(_ sender: UIButton) {
        let unionAB = setA.union(setB).sorted{$0 < $1}
            let unionString = unionAB.joined(separator: ", ")
            labelResultado.text = unionString

    }

    @IBAction func botonAsignarSetB(_ sender: Any) {
        guard let textoB = textoConjuntoB.text, !textoB.isEmpty else {
               displayAlert(withMessage: "Porfavor ingrese algun valor en el campo B")
               return
           }
           
           let conjunto: [String] = textoB.components(separatedBy: ",")
           setB = Set<String>(conjunto.filter { !$0.isEmpty })
           labelResultado.text = textoB
           
           botonUnion.isEnabled = true
           botonInterseccion.isEnabled = true
           botonDiferencia.isEnabled = true
       }

    @IBAction func botonSetAEditingChanged(_ sender: UITextField) {
        if !textoConjuntoB.text!.isEmpty {
            botonAsignarSetB.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder() // Ocultar el teclado
          return true
      }
    

    @IBAction func botonAsignarSetA(_ sender: UIButton) {
        guard let textoA = textoConjuntoA.text, !textoA.isEmpty else {
                displayAlert(withMessage: "Porfavor ingrese algun valor en el campo A")
                return
            }
            
            let conjunto: [String] = textoA.components(separatedBy: ",")
            setA = Set<String>(conjunto.filter { !$0.isEmpty })
            labelResultado.text = textoA
            
            botonAsignarSetB.isEnabled = true // Habilitar botón Set B
            //botonUnion.isEnabled = true
            
           
    }

    @IBAction func textoSetAEditingChange(_ sender: UITextField) {
        if !textoConjuntoA.text!.isEmpty {
            botonAsignarSetA.isEnabled = true
            // Aquí puedes implementar validaciones adicionales según tus necesidades.
        }
    }

    @IBAction func textSetAChanged(_ sender: UITextField) {
        if !textoConjuntoA.text!.isEmpty {
            botonAsignarSetA.isEnabled = true
            // Aquí puedes implementar validaciones adicionales según tus necesidades.
        }
    }
    
    private func displayAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func botonInterseccion(_ sender: UIButton) {
        let intersectionAB = setA.intersection(setB).sorted()
           let intersectionString = intersectionAB.joined(separator: ", ")
           labelResultado.text = intersectionString
    }
    
    
    @IBAction func botonDiferencia(_ sender: UIButton) {
        let differenceAB = setA.subtracting(setB).sorted()
            let differenceString = differenceAB.joined(separator: ", ")
            labelResultado.text = differenceString
    }
    
    
}
