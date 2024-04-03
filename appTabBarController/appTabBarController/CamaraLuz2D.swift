import UIKit
import SceneKit

class CamaraLuz2D: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentoLuces: UISegmentedControl!
    @IBOutlet weak var sliderLuzX: UISlider!
    @IBOutlet weak var sliderLuzY: UISlider!
    @IBOutlet weak var sliderLuzZ: UISlider!
    @IBOutlet weak var sliderCamaraX: UISlider!
    @IBOutlet weak var sliderCamaraY: UISlider!
    @IBOutlet weak var sliderCamaraZ: UISlider!
    
    var tipoLuz: String?
    
    // Propiedades para objetos 3D
    let camara = SCNCamera()
    let camaraNodo = SCNNode()
    let luz = SCNLight()
    let luzNodo = SCNNode()
    let geometriaCubo = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1)
    let cuboNodo = SCNNode()
    let sphereGeometry = SCNSphere(radius: 0.5)
    let sphereNode = SCNNode()
    let planoGeometria = SCNPlane(width: 50.0/3, height: 50.0/3)
    let planoNodo = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipoLuz = "ambient"
        setupScene()
    }
    
    @IBAction func sliderLuzX(_ sender: UISlider) {
        sliderLuzX.value = sender.value
        updateScene()
    }
    
    @IBAction func sliderLuzY(_ sender: UISlider) {
        sliderLuzY.value = sender.value
        updateScene()
    }
    
    @IBAction func sliderLuzZ(_ sender: UISlider) {
        sliderLuzZ.value = sender.value
        updateScene()
    }
    
    @IBAction func sliderCamaraX(_ sender: UISlider) {
        sliderCamaraX.value = sender.value
        updateScene()
    }
    
    @IBAction func sliderCamaraY(_ sender: UISlider) {
        sliderCamaraY.value = sender.value
        updateScene()
    }
    
    @IBAction func sliderCamaraZ(_ sender: UISlider) {
        sliderCamaraZ.value = sender.value
        updateScene()
    }
    
    @IBAction func segmentoTipoLuz(_ sender: UISegmentedControl) {
        let indice: Int = segmentoLuces.selectedSegmentIndex
        
        switch indice {
        case 0: tipoLuz = "ambient"
        case 1: tipoLuz = "directional"
        case 2: tipoLuz = "omni"
        case 3: tipoLuz = "spot"
        default: tipoLuz = "ambient"
        }
        
        updateScene()
    }
    
    func setupScene() {
        let sceneView = SCNView(frame: imageView.bounds)
        imageView.addSubview(sceneView)
        let scene = SCNScene()
        sceneView.scene = scene
        
        camaraNodo.camera = camara
        camaraNodo.position = SCNVector3(sliderCamaraX.value, sliderCamaraY.value, sliderCamaraZ.value)
        
        luz.type = SCNLight.LightType(rawValue: tipoLuz!)
        luz.spotInnerAngle = 30.0
        luz.spotOuterAngle = 70.0
        luz.castsShadow = true
        luzNodo.light = luz
        luzNodo.position = SCNVector3(sliderLuzX.value, sliderLuzY.value, sliderLuzZ.value)
        
        let materialCubo = SCNMaterial()
        materialCubo.diffuse.contents = UIColor.systemCyan
        geometriaCubo.materials = [materialCubo]
        cuboNodo.geometry = geometriaCubo
        cuboNodo.position = SCNVector3(0.5, 0, 0)
        
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.systemGreen
        sphereNode.geometry = sphereGeometry
        sphereNode.position = SCNVector3(2.0, 0, 0)
        
        let materialPlano = SCNMaterial()
        materialPlano.diffuse.contents = UIColor.yellow
        planoGeometria.materials = [materialPlano]
        planoNodo.geometry = planoGeometria
        planoNodo.eulerAngles = SCNVector3(GLKMathDegreesToRadians(-90), 0, 0)
        planoNodo.position = SCNVector3(x: 0.0, y: -0.5, z: 0.0)
        
        let constraint = SCNLookAtConstraint(target: cuboNodo)
        constraint.isGimbalLockEnabled = true
        camaraNodo.constraints = [constraint]
        luzNodo.constraints = [constraint]
        
        scene.rootNode.addChildNode(luzNodo)
        scene.rootNode.addChildNode(camaraNodo)
        scene.rootNode.addChildNode(cuboNodo)
        scene.rootNode.addChildNode(sphereNode)
        scene.rootNode.addChildNode(planoNodo)
    }
    
    func updateScene() {
        camaraNodo.position = SCNVector3(sliderCamaraX.value, sliderCamaraY.value, sliderCamaraZ.value)
        luzNodo.position = SCNVector3(sliderLuzX.value, sliderLuzY.value, sliderLuzZ.value)
    }
}
