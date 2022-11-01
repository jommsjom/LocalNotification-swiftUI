//
//  createnotificationview.swift
//  Notification
//
//  Created by Jomms on 31/10/22.
//

import SwiftUI

struct createnotificationview: View {
    @ObservedObject var notificationManager:Notification
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List{
            Section{
                VStack(spacing: 16){
                    HStack{
                        TextField("Notification Title",text: $title)
                        Spacer()
                        DatePicker("",selection: $date,displayedComponents: .hourAndMinute)
                    }
                    .padding(.vertical,8)
                    .padding(.horizontal,8)
                    .background(Color(.white))
                    .cornerRadius(5)
                    Button{
                        let datecomponent = Calendar.current.dateComponents([.hour,.minute], from: date)
                        guard let hour = datecomponent.hour, let minute = datecomponent.minute else{return}
                        notificationManager.createlocalnotification(title: title, hour: hour, minute: minute) { error in
                            if error == nil{
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                        
                        
                    } label: {
                        Text("Creat")
                        fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }

        .listStyle(InsetListStyle())
        .onDisappear{
            notificationManager.reloadLocalNotification()
        }
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button{
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
            
        })
        
        
    }
}

struct createnotificationview_Previews: PreviewProvider {
    static var previews: some View {
        createnotificationview(
            notificationManager: Notification(),
            isPresented: .constant(false))
    }
}
