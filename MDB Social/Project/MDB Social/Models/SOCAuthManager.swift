//
//  AuthManager.swift
//  MDB Social No Starter
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


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
    
    enum SignUpErrors: Error {
        case emailAlreadyInUse
        case weakPassword
        case internalError
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
        
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                
                switch errorCode {
                case .wrongPassword:
                    completion?(.failure(.wrongPassword))
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                case .invalidEmail:
                    completion?(.failure(.invalidEmail))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                return
            }
            
            //my comment - since no error occured, the user is now linked
            self?.linkUser(withuid: authResult.user.uid, completion: completion)
            
            
            
        }
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    

    
    func signUp(withEmail email: String, userName: String, password: String, fullName: String, completion: ((Result<SOCUser, SignUpErrors>)->Void)?) {
        
        //*READ* my code can succesfully create and write in data for a new user into firebase, I've tested it. I just have NO idea why the feedvc shows up first (if it even is doing that while you'e testing it). I don't know how to solve it either because sometimes the correct sign in page shows up first and sometimes feedvc shows up first, without me changing anything. ok thank you bye
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                
                switch errorCode {
                case .emailAlreadyInUse:
                    completion?(.failure(.emailAlreadyInUse))
                case .weakPassword:
                    completion?(.failure(.weakPassword))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                return
            }
             
            self!.db.collection("users").document(authResult.user.uid).setData([
                "email": email,
                "fullname": fullName,
                "savedEvents": [],
                "username": userName
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {

                    
                    self?.userListener = self?.db.collection("users").document(authResult.user.uid).addSnapshotListener { [weak self] docSnapshot, error in
                        
                        let document = docSnapshot
                        
                        let user = try? document!.data(as: SOCUser.self)
                        self?.currentUser = user
                        completion?(.success(user!))
                        
                        
                    }
               
                    
                }
            }
           
        }
    
    }
                    
        
    
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
        
        userListener = db.collection("users").document(uid).addSnapshotListener { [weak self] docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            guard let user = try? document.data(as: SOCUser.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            
            self?.currentUser = user
            completion?(.success(user))
        }
    }
    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
}
