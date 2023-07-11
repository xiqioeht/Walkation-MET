//
//  Privacy.swift
//  Walkation
//
//  Created by 馬玉駿 on 6/7/2023.
//


import Foundation
import SwiftUI


struct PrivacyView: View {
  
   
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        Text("Walkation ('us', 'we', or 'our') operates the Walkation mobile application (the 'Service'). This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.\n\nData Collection and Use \n\nWe do not collect any personal information from our users, including names, addresses, email addresses, phone numbers, or any other identifying information. We also do not collect any usage data or information about how our Service is used. All registration data and login data are carried out on the local end of the user's cell phone \n\nThird-Party Services \n\nWe do not use any third-party services or tools that collect data or information from our users. This includes data analytics tools, advertising services, or any other third-party services that could potentially collect data from our users. \n\nData Security \n\nWe take reasonable measures to protect the privacy and security of our users' data. However, please note that no data transmission over the Internet or any wireless network can be guaranteed to be 100% secure. As a result, while we strive to protect our users' personal information, we cannot ensure or warrant the security of any information that you transmit to us, and you do so at your own risk.\n\nLocation\n\nWe are not collect any user location and sensitive data.  \n\nContact Us \n\nIf you have any questions or concerns regarding our Privacy Policy or the use of your personal information, please contact us at shoudaokui@foxmail.com. \n\nChanges to this Privacy Policy \n\nWe may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. We will also update the 'effective date' at the top of this Privacy Policy. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.")
                           
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            
                    }
                }
                .navigationTitle("Privacy Policy")
            }
        }

    

 
}

struct PrivacyView_Previews: PreviewProvider {
    
    static var previews: some View {
       PrivacyView()
    }
}
