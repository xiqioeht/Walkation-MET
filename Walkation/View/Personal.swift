//
//  Personal.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct Personal: View {
    @State private var showingDeleteAlert = false

    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Text("Walkie")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(Color("Green"))
                            
                            Text("PolyU, HK\n\nI love walkation.")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                    
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    // Custom Navigation Links...
                    
                   /* CustomNavigationLink(title: "Edit Profile 📝") {
                        
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    */
                    CustomNavigationLink(title: "Walkation Records 🍀") {
                        
                     /*   Text("")
                            .navigationTitle("Walkation Records")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                        */
                        PersonalMoodView()
   
                        
                    }
                    
                    CustomNavigationLink(title: "Character Selection 🧸") {
                        CharacterSelection()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Role Customization 🌟") {
                        RoleCustomization()
                            .navigationTitle("Role Customization")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Privacy Policy 🛡️") {
                       
                        PrivacyView()
                    }
                    
                   
                            Button(action: {
                                showingDeleteAlert = true
                            }) {
                                HStack {
                           
                                    
                                    Text("Delete Account ❌")
                                        .font(.custom(customFont, size: 17))
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "trash")
                                    
                                    
                                }  .foregroundColor(.black)
                                    .padding()
                                    .background(
                                    
                                        Color.white
                                            .cornerRadius(12)
                                    )
                                    .padding(.horizontal)
                                    .padding(.top,10)
                            }
                            .alert(isPresented: $showingDeleteAlert) {
                                Alert(
                                    title: Text("Delete Account"),
                                    message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                                    primaryButton: .destructive(Text("Delete"), action: {
                                        // Call function to delete account here
                                        
                                        print("delete now")
                                        let db = DBHelper()
                                        db.updateStatus(email: DBHelper.currentLoginEmail)
                                        
                                        //logout
                                        UserDefaults.standard.set(false, forKey: "log_Status")
                                        OnBoardingPage()
                                        //clear data
                                        DBHelper.currentPassword = ""
                                        DBHelper.currentLoginEmail = ""
                                        DBHelper.currentLoginStatus = ""
                                        
                                    }),
                                    secondaryButton: .cancel()
                                )
                            }
                        
             
                
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "log_Status")
                    OnBoardingPage()
                    DBHelper.currentPassword = ""
                    DBHelper.currentLoginEmail = ""
                    DBHelper.currentLoginStatus = ""
                    
                }) {
                    HStack {
               
                        
                        Text("Log Out 👉🏿")
                            .font(.custom(customFont, size: 17))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                    
                        
                    }  .foregroundColor(.black)
                        .padding()
                        .background(
                        
                            Color.white
                                .cornerRadius(12)
                        )
                        .padding(.horizontal)
                        .padding(.top,10)
                }
               
            }
            
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}

struct Personal_Previews: PreviewProvider {
    static var previews: some View {
        Personal()
    }
}


