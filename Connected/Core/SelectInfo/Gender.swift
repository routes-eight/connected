//
//  4_gender.swift
//  Connected
//
//  Created by 정근호 on 4/15/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Gender: View {
    
    @State private var showNextScreen = false
    @State private var selectedGender: String? = nil
    
    let db = Firestore.firestore()

    
    let user : User
    
    enum Gender {
        case male, female
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width/8*3, height: 5)
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 5)
                            .foregroundStyle(Color.gray)
                            .opacity(0.2)
                    }
                    Spacer()
                    Text("성별이 무엇인가요?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button(action: {
                        selectedGender = "male"
                    }) {
                        Text("남자")
                            .frame(width: 250)
                            .foregroundColor(selectedGender == "male" ? .white : .gray)
                            .padding()
                            .background(selectedGender == "male" ? Color.black : Color(UIColor.systemGray5))
                            .cornerRadius(30)
                        
                        
                    }
                    .padding(0.0)
                    Button(action: {
                        selectedGender = "female"
                    }) {
                        Text("여자")
                            .frame(width: 250)
                            .foregroundColor(selectedGender == "female" ? .white : .gray)
                            .padding()
                            .background(selectedGender == "female" ? Color.black : Color(UIColor.systemGray5))
                            .cornerRadius(30)
                    }
                    Spacer()
                }
                .padding(.bottom, 400)
                
                VStack {
                    Spacer()
                    Button(action: {
                        if selectedGender != nil {
                            print("성별: \(selectedGender ?? "no sex")")
                            showNextScreen = true
                        }
                        Task {
                            
                            do {
                                // 현재 로그인한 사용자의 UID 가져오기
                                guard let userId = Auth.auth().currentUser?.uid else {
                                    print("No user is signed in.")
                                    return
                                }
                                
                                // 사용자 UID를 사용하여 문서 업데이트 또는 생성
                                try await db.collection("users").document(userId).setData([
                                    "Gender": selectedGender as Any
                                ], merge: true)  // merge: true를 사용하여 기존 데이터를 유지하면서 업데이트
                                
                                print("Document updated for user: \(userId)")
                                showNextScreen = true
                            } catch {
                                print("Error updating document: \(error)")
                            }
                            
                        }
                        
                    }) {
                        Text("다음")
                            .frame(width: 250)
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedGender == nil ? .unselectedButton: .black)
                            .cornerRadius(30)
                    }
                    .disabled(selectedGender == nil)
                    .navigationDestination(isPresented: $showNextScreen)
                    {
                        AboutYourself(user: user)
                    }
                }
            }
        }//NavigationStack
        .tint(.black)
    }
}

#Preview {
    Gender(user: User.MOCK_USERS[0])
}
