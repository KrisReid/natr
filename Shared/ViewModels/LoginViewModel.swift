//
//  LoginViewModel.swift
//  natr
//
//  Created by Kris Reid on 02/08/2021.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class LoginViewModel: ObservableObject {

    @Published var name = ""
    @Published var mobileNumber = ""
    @Published var imageUrl = ""

    @Published var code = ""
    @Published var CODE = ""

    @Published var errorMsg = ""
    @Published var error = false
    @Published var loading = false
    @Published var gotoVerify = false
    @Published var accountCreation = false
    
    @Published var inputImage: UIImage?

    // User Logged in Status
    @AppStorage("log_Status") var status = false
    
    let crypto = Crypto()

    func getCountryCode() -> String {
        let countryCode = Locale.current.regionCode ?? ""
        return countries[countryCode] ?? ""
    }

    func sendCode(){
        self.loading = true

        //false = Real Device Testing ---OR--- true = Mock Testing
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false

        //Set for testing on simulator
        let number = "+\(getCountryCode())\(mobileNumber)"

        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in

            if let error = err {
                self.loading = false
                print(error.localizedDescription)
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }

            self.CODE = CODE ?? ""
            self.gotoVerify = true
            self.loading = false
        }
    }

    func verifyCode(){

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)

        self.loading = true

        Auth.auth().signIn(with: credential) { (result, err) in

            if let error = err{
                self.loading = false
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }
            

            self.checkUser { [self] (exists, name, mobileNumber, imageUrl, groups) in
                 if exists {

                    self.name = name
                    self.mobileNumber = mobileNumber
                    self.imageUrl = imageUrl

                    self.loading = false
                    withAnimation{self.status = true}

                 }
                 else {
                    self.loading = false
                    self.accountCreation.toggle()
                 }
            }
        }
    }


    func checkUser(completion: @escaping (_ exists: Bool, _ name: String, _ mobileNumber: String, _ image: String, _ groups: [String]) -> Void){

        Firestore.firestore().collection("users").getDocuments { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }

            for i in snap!.documents{
                if i.documentID == Auth.auth().currentUser?.uid {
                    completion(true,i.get("name") as! String,i.get("mobileNumber") as! String,i.get("imageUrl") as! String, i.get("groups") as! [String])
                    return
                }
            }
            completion(false,"","","",[])
        }
    }



    func CreateUser() {
        if self.name != "" {

            self.loading = true
            
            //Generate some crypto tokens
            let publicToken = crypto.generateCryptoKeys()

            let db = Firestore.firestore().collection("users")
            let storage = Storage.storage().reference().child("users")
            let uid = Auth.auth().currentUser?.uid ?? ""

            if let uploadData = self.inputImage!.jpegData(compressionQuality: 0.75) {

                storage.child("\(uid).jpeg").putData(uploadData, metadata: nil) { (meta, error) in
                    if let error = error {
                        self.errorMsg = error.localizedDescription
                        withAnimation{ self.error.toggle()}
                        self.loading = false
                    } else {
                        storage.child("\(uid).jpeg").downloadURL { (url, error) in
                            if let url = url, error == nil {
                                let userProfileImage = url.absoluteString
                                
                                let user: [String:Any] = [
                                    "id" : uid,
                                    "name" : self.name,
                                    "mobileNumber" : "+\(self.getCountryCode())\(self.mobileNumber)",
                                    "imageUrl" : userProfileImage,
                                    "fcmToken" : "",
                                    "publicToken" : publicToken,
                                    "groups" : [""],
                                    "favourites" : [""]
                                ]

                                db.document(uid).setData(user) { err in
                                    self.loading = false
                                    if err != nil {
                                        self.errorMsg = err?.localizedDescription ?? "Error"
                                        withAnimation{ self.error.toggle()}
                                    } else {
                                        self.accountCreation.toggle()
                                        withAnimation{self.status = true}
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            self.errorMsg = "Name field can not be empty"
            withAnimation{ self.error.toggle()}
        }
    }


}

