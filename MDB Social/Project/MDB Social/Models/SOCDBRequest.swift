//
//  SOCDBRequest.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseFirestore

class SOCDBRequest {
    
    static let shared = SOCDBRequest()
    
    var allEvents: [SOCEvent]

    init() {
        allEvents = []
    }
    
    let db = Firestore.firestore()
    
  
    
    func setUser(_ user: SOCUser, completion: (()->Void)?) {
        guard let uid = user.uid else { return }
        do {
            try db.collection("users").document(uid).setData(from: user)
            completion?()
        }
        catch { }
    }

    func setEvent(_ event: SOCEvent, completion: (()->Void)?) {
        guard let id = event.id else { return }

        do {
            try db.collection("events").document(id).setData(from: event)
            completion?()
        } catch { }
    }
    
    /* TODO: Events getter */
    // For example, see SOCAuthManager.linkUser(withuid:completion:)

    func getEvents(withuid uid: String,
                   completion: (()->Void)?){
        
     

        var userListener: ListenerRegistration?

        userListener = self.db.collection("events").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
//                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let event = try? document.data(as: SOCEvent.self) else {
//                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            
            self?.allEvents.append(event)


    }


    }
}
