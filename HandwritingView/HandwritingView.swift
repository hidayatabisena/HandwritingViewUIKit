//
//  HandwritingView.swift
//  HandwritingView
//
//  Created by Hidayat Abisena on 11/04/23.
//

import UIKit

class HandwritingView: UIView {
    
    private var previousPoint: CGPoint = .zero
    private var strokeWidth: CGFloat = 3.0
    private var strokeColor: UIColor = .black
    private var drawingImage: UIImage?
    private var placeholder: String?
    
    init(frame: CGRect, placeholder: String?) {
        super.init(frame: frame)
        self.placeholder = placeholder
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawingImage?.draw(in: rect)
        
        if let placeholder = placeholder {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .foregroundColor: UIColor.lightGray
            ]
            let textSize = placeholder.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (bounds.width - textSize.width) / 2,
                y: (bounds.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
            placeholder.draw(in: textRect, withAttributes: attributes)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        previousPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        drawLine(from: previousPoint, to: currentPoint)
        previousPoint = currentPoint
    }
    
    private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        drawingImage?.draw(in: bounds)
        context?.move(to: startPoint)
        context?.addLine(to: endPoint)
        context?.setLineWidth(strokeWidth)
        context?.setStrokeColor(strokeColor.cgColor)
        context?.strokePath()
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setNeedsDisplay()
    }
    
    func clear() {
        drawingImage = nil
        setNeedsDisplay()
    }
    
    func setStrokeWidth(_ width: CGFloat) {
        strokeWidth = width
    }
    
    func setStrokeColor(_ color: UIColor) {
        strokeColor = color
    }
    
    func getHandwritingImage() -> UIImage? {
        return drawingImage
    }
    
}
