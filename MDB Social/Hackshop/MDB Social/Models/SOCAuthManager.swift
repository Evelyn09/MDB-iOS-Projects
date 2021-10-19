//
//  AuthManager.swift
//  MDB Social No Starter
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Metal

class SOCAuthManager {
    
    static let shared = SOCAuthManager()
    
    let auth = Auth.auth()
    
    enum SignInErrors: Error {
        case wrongPassword
        case userNotFound
        case invalidEmail
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    
    let db = Firestore.firestore()
    
    var currentUser: SOCUser?
    
    private var userListener: ListenerRegistration?
    
    init() {
        guard let user = auth.currentUser else { return }
        
        linkUser(withuid: user.uid, completion: nil)
    }
    
    func signIn(withEmail email: String, password: String,
                completion: ((Result<SOCUser, SignInErrors>)->Void)?) {
        
        /* TODO: Hackshop */
        auth.signIn(signIn(withEmail: email, password: password, completion: {
            (authResults: AuthDataResult?, error: Error?)-> Void in
            
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                switch errorCode{
                //this is creating results
                case .wrongPassword:
                    completion?(.failure(SignInErrors.wrongPassword))
                
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                default:
                    completion?(failture(.unspecified))
                }
                
            return
                
        }
        
            guard let authResult = authResult else{
                completion?(.failure(.internalError))
                return
            }
            
            self.linkUser(withuid: authResult.user.id, completion: completion)
            
        })
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOut(completion: (()->Void)? = nil) {
        do {
            try auth.signOut()
            unlinkCurrentUser()
            completion?()
        } catch { }
    }
    
    private func linkUser(withuid uid: String,
                          completion: ((Result<SOCUser, SignInErrors>)->Void)?) {
        
        /* TODO: Hackshop */
            userListener = db.collection("users").document(uid).addSnapshotListener
            {
                
            }
    }
    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
}
