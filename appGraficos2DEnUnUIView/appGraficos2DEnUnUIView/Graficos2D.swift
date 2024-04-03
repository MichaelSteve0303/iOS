//
//  Graficos2D.swift
//  appGraficos2DEnUnUIView
//
//  Created by Michael Steve Espinoza Perez on 18/05/23.
//

import UIKit

class Graficos2D: UIView {
    internal var x1: Int = 0
    public var y1: Int = 0
    public var x2: Int = 0
    public var y2: Int = 0
    
    internal var pcx1: Int = 0
    public var pcy1: Int = 0
    public var pcx2: Int = 0
    public var pcy2: Int = 0
    
    public var ancho: Int = 0
    public var alto: Int = 0
    
    public var sliderValue: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // Limpiar el fondo
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        // Definir el tamaño de los ejes y su posición
        let axisWidth: CGFloat = 2.0
        let axisColor = UIColor.black.cgColor
        let axisPadding: CGFloat = 20.0
        
        let xAxisY = rect.height - axisPadding
        let yAxisX = axisPadding
        
        // Dibujar ejes x e y
        context.setStrokeColor(axisColor)
        context.setLineWidth(axisWidth)
        context.move(to: CGPoint(x: yAxisX, y: 0))
        context.addLine(to: CGPoint(x: yAxisX, y: xAxisY))
        context.strokePath()
        
        context.move(to: CGPoint(x: yAxisX, y: xAxisY))
        context.addLine(to: CGPoint(x: rect.width, y: xAxisY))
        context.strokePath()
        
        // Dibujar marcas en los ejes
        let axisMarkWidth: CGFloat = 4.0
        let axisMarkColor = UIColor.darkGray.cgColor
        
        context.setStrokeColor(axisMarkColor)
        context.setLineWidth(axisMarkWidth)
        
        // Marca en el eje x
        let xAxisMarkHeight: CGFloat = 10.0
        let xAxisMarkSpacing: CGFloat = 50.0
        
        var currentX = yAxisX
        while currentX <= rect.width {
            context.move(to: CGPoint(x: currentX, y: xAxisY - (xAxisMarkHeight / 2)))
            context.addLine(to: CGPoint(x: currentX, y: xAxisY + (xAxisMarkHeight / 2)))
            context.strokePath()
            
            currentX += xAxisMarkSpacing
        }
        
        // Marca en el eje y
        let yAxisMarkWidth: CGFloat = 10.0
        let yAxisMarkSpacing: CGFloat = 50.0
        
        var currentY = xAxisY
        while currentY >= 0 {
            context.move(to: CGPoint(x: yAxisX - (yAxisMarkWidth / 2), y: currentY))
            context.addLine(to: CGPoint(x: yAxisX + (yAxisMarkWidth / 2), y: currentY))
            context.strokePath()
            
            currentY -= yAxisMarkSpacing
        }
        
        // Dibujar la curva de Bezier
        let bezierPath = UIBezierPath()
        
        let controlPoint1 = CGPoint(x: pcx1, y: pcy1)
        let controlPoint2 = CGPoint(x: pcx2, y: pcy2)
        let intermediatePoint = calculateIntermediatePoint(controlPoint1: controlPoint1, controlPoint2: controlPoint2, sliderValue: sliderValue)
        
        bezierPath.move(to: CGPoint(x: x1, y: y1))
        bezierPath.addQuadCurve(to: CGPoint(x: x2, y: y2), controlPoint: intermediatePoint)
        
        let bezierColor = UIColor.red
        bezierColor.setStroke()
        bezierPath.lineWidth = 2.0
        bezierPath.stroke()
    }
    
    private func calculateIntermediatePoint(controlPoint1: CGPoint, controlPoint2: CGPoint, sliderValue: CGFloat) -> CGPoint {
        let x = (1 - sliderValue) * (1 - sliderValue) * controlPoint1.x + 2 * (1 - sliderValue) * sliderValue * controlPoint1.x + sliderValue * sliderValue * controlPoint2.x
        let y = (1 - sliderValue) * (1 - sliderValue) * controlPoint1.y + 2 * (1 - sliderValue) * sliderValue * controlPoint1.y + sliderValue * sliderValue * controlPoint2.y
        
        return CGPoint(x: x, y: y)
    }
}
