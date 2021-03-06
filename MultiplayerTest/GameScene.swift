//
//  GameScene.swift
//  MultiplayerTest
//
//  Created by Linder Hassinger on 30/10/21.
//

import SpriteKit
import GameplayKit

class GameScene: ConnectedScene {
    
    var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var dados = 0
    var oponente = 0
    var negociacion = 0
    
    override func didMove(to view: SKView) {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate.mpcHandler.scene = self
        label = SKLabelNode(text: "Esperando...")
        label?.fontSize = 70
        
        self.addChild(label!)
    }

    func touchDown(atPoint pos : CGPoint) {
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
        if negociacion == 2 {
            var first = false
            first = dados > oponente // bool
            appDelegate.mpcHandler.turn = first
            let gamePlay = SKScene(fileNamed: "GamePlay")!
            let transition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(gamePlay, transition: transition)
        }
    }
    
    override func reciveData(data: String) {
        let recivedData = Int(data)
        
        if recivedData == 200 {
            // Esto seria la data que yo envio
            dados = Int.random(in: 1..<7)
            appDelegate.mpcHandler.sendData(data: "\(dados)")
            negociacion += 1
        } else {
            // Esto seria la data que yo recibo
            oponente = recivedData!
            negociacion += 1
        }
    }
}
