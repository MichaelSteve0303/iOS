import UIKit

class ConversorNumerico: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var num1: Int = 0
    var num2: Int = 0
    
    @IBOutlet weak var labelNumero: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var stepper1: UIStepper!
    @IBOutlet weak var segmento1: UISegmentedControl!
    @IBOutlet weak var texto1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelNumero.text = String(Int(slider1.value))
        
        // Configurar el delegado del campo de texto
        texto1.delegate = self
        
        stepper1.addTarget(self, action: #selector(stepper1Changed(_:)), for: .valueChanged)
    }
    
    @IBAction func slider1Moved(_ sender: UISlider) {
        labelNumero.text = "\(String(describing: lround(Double(sender.value))))"
        stepper1.value = Double(sender.value)
        self.segmentSelected(segmento1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Ocultar el teclado
        return true
    }
    
    @objc func stepper1Changed(_ sender: UIStepper) {
        labelNumero.text = "\(String(describing: lround(Double(sender.value))))"
        slider1.value = Float(sender.value)
    }
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        let indice: Int = sender.selectedSegmentIndex
        let num: Int = Int(labelNumero.text!)!
        
        if indice == 0 {
            let binaryString = String(num, radix: 2)
            texto1.text = binaryString
        } else if indice == 1 {
            let octalString = String(num, radix: 8)
            texto1.text = octalString
        } else if indice == 2 {
            let hexString = String(num, radix: 16)
            texto1.text = hexString
        }
    }
}
