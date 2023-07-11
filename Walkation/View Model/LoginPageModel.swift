
import SwiftUI

class LoginPageModel: ObservableObject {
    
    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    let db = DBHelper()
    // Login Call...
    func Login(email:String,password:String){
        // Do Action Here...
        print("login tapped")
        print("login email is\(email)")
        print("login password is\(password)")
       
            if(DBHelper.isOKLogin){
                //true login
                //login success
                print("login success")
                
                
                withAnimation{
                      log_Status = true
                    
                }
                
            }else{
                print("login failed")
                withAnimation{
                      log_Status = false
                    
                }
            }
            
            
           
      
     
        
    }
    
    func Register(email:String,password:String,repassword:String){
        // Do Action Here...
        print("register tapped")
        print("register email is\(email)")
        print("register password is\(password)")
        print("register repassword is\(repassword)")
        if(isValidEmail(email: email)){
            //true
            print("true register email")
            //do register action
            if(email != "" && password != "" && repassword != ""){
               print("Register Action and insert into database")
             
                db.insertAc(email: email, password: password)
                print("Register account.........")
                if(DBHelper.isOKRegister){
                    //true
                    withAnimation{
                        log_Status = true
                    }
                }else{
                    //fail register
                    withAnimation{
                        log_Status = false
                    }
                }
              
                
                print("read data")
             
                
            }else{
                print("Null Value")
            }
            
           
            
        }else{
            //false
            
        }
       
    }
    
    func ForgotPassword(){
        // Do Action Here...
        
        
    }
    

    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
  


 
   
    
}
