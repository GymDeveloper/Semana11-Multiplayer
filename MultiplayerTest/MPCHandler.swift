//
//  MPCHandler.swift
//  MultiplayerTest
//
//  Created by Linder Hassinger on 30/10/21.
//

import Foundation
import SpriteKit
import MultipeerConnectivity

class MPCHandler: NSObject, MCSessionDelegate {
    
    var peerID: MCPeerID!
    var session: MCSession!
    var browser: MCBrowserViewController!
    var adversiter: MCAdvertiserAssistant?
    // nos falta declarar nuestra escena
    var scene: ConnectedScene?
    var turn = false
    
//    Obtener el nombre
    func setUpSuperWithDisplyName(displayName: String) {
        peerID = MCPeerID(displayName: displayName)
    }
    
//    Hago el setUp de mi session
    func setUpSession() {
        session = MCSession(peer: peerID)
        session.delegate = self
    }
    
//    setUp del browser
    func setUpBrowser() {
        browser = MCBrowserViewController(serviceType: "my-game", session: session)
    }
    
    func adversiteSelf(adversite: Bool) {
        if adversite {
            adversiter = MCAdvertiserAssistant(serviceType: "my-game", discoveryInfo: nil, session: session)
            adversiter!.start()
        } else {
            adversiter!.stop()
            adversiter = nil
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        Vamos a verificar si el otro usuario se conceto o no
        switch state {
            case .notConnected:
                print(peerID.displayName)
            case .connecting:
                print(peerID.displayName)
            case .connected:
                print(peerID.displayName)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let recived_data = String(decoding: data, as: UTF8.self)
        self.scene?.reciveData(data: recived_data)
    }
    
    func sendData(data: String) {
        if session.connectedPeers.count > 0 {
            do {
                print(data)
                try session.send(Data(data.utf8), toPeers: session.connectedPeers, with: .reliable)
            } catch let error as NSError {
                let alert = UIAlertController(title: "Error to send", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
}
