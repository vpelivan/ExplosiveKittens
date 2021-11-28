//
//  BluetoothService.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 23.11.2021.
//

import MultipeerConnectivity

enum Peers {
    case all
    case concrete(String)
}

final class BluetoothService: NSObject {
    
    private var peerId: MCPeerID?
    private var session: MCSession?
    private var advertiserAssistant: MCAdvertiserAssistant?
    
    private var closeBrowserClosure: ((UIViewController) -> Void)?
    private var cancelBrowserClosure: ((UIViewController) -> Void)?
    private var recieveDataFromPeerClosure: ((_ data: Data, _ peerIdName: String) -> Void)?
    
    private var connectedPeers: [MCPeerID] {
        guard let session = session else {
            return []
        }
        return session.connectedPeers
    }
    
    var myPeerName: String? {
        return session?.myPeerID.displayName
    }
    
    init(
        closeBrowserClosure: ((UIViewController) -> Void)? = nil,
        cancelBrowserClosure: ((UIViewController) -> Void)? = nil
    ) {
        super.init()
        self.closeBrowserClosure = closeBrowserClosure
        self.cancelBrowserClosure = cancelBrowserClosure
    }
    
    deinit {
        disconnect()
    }
    
    // MARK: - Connection Methods
    
    func connect(withName: String = UIDevice.current.name) {
        peerId = MCPeerID(displayName: withName)
        guard let peerId = peerId else {
            return
        }
        session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
    }
    
    func disconnect() {
        session?.disconnect()
    }
    
    // MARK: - Host Session
    
    func hostSession() {
        guard let session = session else {
            return
        }
        advertiserAssistant = MCAdvertiserAssistant(
            serviceType: "vp-ek",
            discoveryInfo: nil,
            session: session
        )
        advertiserAssistant?.start()
    }
    
    func stopHostingSession() {
        advertiserAssistant?.stop()
    }
    
    // MARK: - Join Session
    
    func joinSession(browserHandler: (UIViewController) -> Void) {
        guard let session = session else {
            return
        }
        let browser = MCBrowserViewController(serviceType: "vp-ek", session: session)
        browser.delegate = self
        browser.minimumNumberOfPeers = 2
        browser.maximumNumberOfPeers = 5
        // present(browser, animated: true, completion: nil)
        browserHandler(browser)
    }
    
    // MARK: - Send Data
    
    func send(data: Data, to peers: Peers) {
        guard let peers = choosePeers(from: peers) else {
            return
        }
        
        do {
            try session?.send(data, toPeers: peers, with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func choosePeers(from peerType: Peers) -> [MCPeerID]? {
        switch peerType {
        case .all:
            return connectedPeers
        case .concrete(let name):
            guard let concrete = connectedPeers.first(where: { $0.displayName == name }) else {
                return nil
            }
            return [concrete]
        }
    }
}


// MARK: - MCSession Delelegate Methods

extension BluetoothService: MCSessionDelegate {

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("Not connected \(peerID.displayName)")
        case .connecting:
            print("Connecting \(peerID.displayName)")
        case .connected:
            print("Connected \(peerID.displayName)")
        default:
            print("Unknown connection state")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        recieveDataFromPeerClosure?(data, peerID.displayName)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

// MARK: - MCBrowserViewController Delelegate Methods

extension BluetoothService: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        closeBrowserClosure?(browserViewController)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        cancelBrowserClosure?(browserViewController)
    }
}
