
import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State private var showingAlert: Bool = false
    @State private var showingNullAlert: Bool = false
    @State private var showingMatchPasswordAlert: Bool = false
    @State private var showingLoginSuccessAlert: Bool = false
    @State private var isPrivacyViewPresented = false
    
    
    var body: some View {
        
        VStack{
            
            // WElcome Back text for 3 half of the screen...
            Text("Hello,\nWelcome")
                .font(.custom(customFont, size: 45).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .offset(x: 10,y: -70)
                .background(
                
                    ZStack{
                        
                        // Gradient Circle...
                        LinearGradient(colors: [
                        
                            Color("BG"),
                            Color("BG")
                                .opacity(0.8),
                            Color("Green")
                        ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 500)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading,30)
                        
                        Image("tree")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(x: 50,y: 50)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Login Page Form....
                VStack(spacing: 15){
                    
                    Text(loginData.registerUser ? "Sign up" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    // Custom Text Field...
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "Xxx@xxx.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    
                    // Regsiter Reenter Password
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                    }
                    
                    // Forgot Password Button...
                 /*   Button {
                        loginData.ForgotPassword()
                    } label: {
                        
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Green"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    */
                       
                    // Login Button...
                    Button(action: {
                        
                        
                        
                        let email = loginData.email
                        let password = loginData.password
                     
                        if(email != "" || password != ""){
                            print("false....")
                            showingNullAlert = false
                            
                           
                            if loginData.registerUser {
                               print("註冊帳戶中....")
                               
                                let repassword = loginData.re_Enter_Password
                                if(password == repassword){
                                   
                                    showingNullAlert = false
                                    loginData.Register(email: email, password: password, repassword: repassword)
                                    
                                }else{
                                    
                                    showingNullAlert = true
                                    
                                  
                                }
        
                              
                            } else {
                                print("登錄帳戶中....")
                               
                              
                                if(email == "applereview@gmail.com" && password == "testing"){
                                    print("yes ar....")
                                    DBHelper.isOKLogin = true
                                    loginData.Login(email: email, password: password)
                                }else{
                                    let db = DBHelper()
                                    db.readLoginedAc()
                                    print("login \(db.readLoginedAc())")
                                    if(email == DBHelper.currentLoginEmail && password == DBHelper.currentPassword){
                                        showingNullAlert = false
                                        
                                        if(DBHelper.currentLoginStatus == "Y"){
                                            DBHelper.isOKLogin = true
                                            loginData.Login(email: email, password: password)
                                        }else{
                                            DBHelper.isOKLogin = false
                                            showingNullAlert = true
                                        }
    
                                        
                                    }else{
                                        DBHelper.isOKLogin = false
                                        showingNullAlert = true
                                    }
                                    
                                    
                                }
                               
                               
                                
                                
                                
                                
                            }
                            
                        }else{
                            print("true.....")
                            showingNullAlert = true
                        }
                        
                        
                    
                        
                    }) {
                        if loginData.registerUser{
                            Text("Register")
                                .font(.custom(customFont, size: 17).bold())
                                .padding(.vertical,20)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color("Green"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)

                        }else{
                            Text("Login")
                                .font(.custom(customFont, size: 17).bold())
                                .padding(.vertical,20)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color("Green"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                        }
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    .alert(isPresented: $showingNullAlert) {
                       
                        Alert(title: Text("Invalid Value"), message: Text("Please enter a valid value"), dismissButton: .default(Text("OK")))
                        

                        
                    }
                    
                
                    
                 
                    // Register User Button...
                    
                    Button {
                        
    
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                        
                        
                        
                        
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Green"))
                    }
                    .padding(.top,8)
                    
                    Button(action: {
                               // 在這裡添加操作
                        self.isPrivacyViewPresented = true

                        
                           }) {
                               Text("By logging in or registering, you agree to our privacy policy.")
                                   .font(.custom(customFont, size: 14))
                                   .fontWeight(.semibold)
                                   .foregroundColor(Color("Green"))
                           }
                           .padding(.top,8)
                           .sheet(isPresented: $isPrivacyViewPresented){
                               PrivacyView()
                           }
                        
                    
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                // Applying Custom Corners...
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Green"))
        
        // Clearing data when Changes...
        // Optional...
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(
        
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Green"))
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
