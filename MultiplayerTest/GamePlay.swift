//
//  GamePlay.swift
//  MultiplayerTest
//
//  Created by Linder Hassinger on 30/10/21.
//

import SpriteKit
import Foundation
import GameplayKit
import MultipeerConnectivity

class GamePlay: ConnectedScene {
    
    public var turn = false
    
    override func didMove(to view: SKView) {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate.mpcHandler.scene = self
        self.turn = appDelegate.mpcHandler.turn
        let label = SKLabelNode(text: "Turno")
        
        label.text = "Segundo"
        
        if self.turn {
            label.text = "Primero"
        }
        
        print(label)
        label.fontSize = 70
        self.addChild(label)
    }
    
    func touchDown(atPoint pos: CGPoint) {
        // Esta funcion envia las coordenadas del click
        appDelegate.mpcHandler.sendData(data: "\(pos.x),\(pos.y)")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
        }
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(toPoint: touch.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchUp(atPoint: touch.location(in: self))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
//    Vamos a pintar la informacion que recibimos
    override func reciveData(data: String) {
        let touch = SKShapeNode(circleOfRadius: 10.0)
        
        if data != "Hola" {
            let pos = data.components(separatedBy: ",")
            touch.position.x = convertCGFloat(number: pos[0])
            touch.position.y = convertCGFloat(number: pos[1])
            self.addChild(touch)
        }
        
    }
    
    func convertCGFloat(number: String) -> CGFloat {
        return CGFloat(Double(number)!)
    }
    
}
