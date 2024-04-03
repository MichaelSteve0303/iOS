import UIKit
import SceneKit

class Graficos3D: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var lateralSlider: UISlider!
    @IBOutlet weak var verticalSlider: UISlider!
    @IBOutlet weak var rotationSlider: UISlider!
    
    var rootNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupSliders()
    }
    
    private func setupScene() {
        let scene = SCNScene()
        sceneView.scene = scene
        
        rootNode = SCNNode()
        scene.rootNode.addChildNode(rootNode)
        
        let gridSize = 25
        let capsuleRadius: CGFloat = 1.0 / CGFloat(gridSize - 1)
        let capsuleHeight: CGFloat = capsuleRadius * 4.0
        
        var z: Float = Float(-gridSize + 1) * Float(capsuleRadius)
        
        for row in 0..<gridSize {
            var x: Float = Float(-gridSize + 1) * Float(capsuleRadius)
            
            for column in 0..<gridSize {
                let capsule = SCNCapsule(capRadius: capsuleRadius, height: capsuleHeight)
                
                let hue = CGFloat(abs(x * z))
                let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
                capsule.firstMaterial?.diffuse.contents = color
                
                let capsuleNode = SCNNode(geometry: capsule)
                rootNode.addChildNode(capsuleNode)
                
                capsuleNode.position = SCNVector3(x, 0.0, z)
                
                let y = CGFloat(squareFunction(x, z: z))
                let moveUp = SCNAction.moveBy(x: 0, y: y, z: 0, duration: 1.0)
                let moveDown = SCNAction.moveBy(x: 0, y: -y, z: 0, duration: 1.0)
                let sequence = SCNAction.sequence([moveUp, moveDown])
                let repeatedSequence = SCNAction.repeatForever(sequence)
                capsuleNode.runAction(repeatedSequence)
                
                x += 2.0 * Float(capsuleRadius)
            }
            
            z += 2.0 * Float(capsuleRadius)
        }
    }
    
    private func setupSliders() {
        lateralSlider.minimumValue = -1.0
        lateralSlider.maximumValue = 1.0
        lateralSlider.value = 0.0
        lateralSlider.addTarget(self, action: #selector(lateralSliderValueChanged(_:)), for: .valueChanged)
        
        verticalSlider.minimumValue = -1.0
        verticalSlider.maximumValue = 1.0
        verticalSlider.value = 0.0
        verticalSlider.addTarget(self, action: #selector(verticalSliderValueChanged(_:)), for: .valueChanged)
        
        rotationSlider.minimumValue = -Float.pi
        rotationSlider.maximumValue = Float.pi
        rotationSlider.value = 0.0
        rotationSlider.addTarget(self, action: #selector(rotationSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func lateralSliderValueChanged(_ sender: UISlider) {
        let lateralValue = sender.value
        rootNode.position.x = lateralValue
    }
    
    @objc private func verticalSliderValueChanged(_ sender: UISlider) {
        let verticalValue = sender.value
        rootNode.position.y = verticalValue
    }
    
    @objc private func rotationSliderValueChanged(_ sender: UISlider) {
        let rotationValue = sender.value
        let rotationAngle = SCNVector3(rotationValue, 0.0, 0.0)
        rootNode.eulerAngles = rotationAngle
    }
    
    private func squareFunction(_ x: Float, z: Float) -> Float {
        return x * x + z * z
    }
}
