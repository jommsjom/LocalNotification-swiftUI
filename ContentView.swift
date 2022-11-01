//
//  ContentView.swift
//  Notification
//
//  Created by Jomms on 29/10/22.
//

import SwiftUI

struct ContentView: View {
@StateObject private var notificationManager = Notification()
@State private var isCreatePresented = false
    var body: some View {
        List(notificationManager.notifications,id: \.identifier) { notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
        }
        .listStyle(InsetListStyle())
        .navigationTitle("Notification")
        .onAppear(perform: notificationManager.reloadstatus)
        .onChange(of: notificationManager.authorizationStatus){ authorizationStatus in  switch authorizationStatus{
        case.notDetermined:
            notificationManager.requestauthorization()
           
        case .authorized:
            //get local notifications
      break
        default:
            break
        }
    }
        .navigationBarItems(trailing: Button {
            
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented){
            NavigationView{
                createnotificationview(
                    notificationManager: notificationManager,
                    isPresented: $isCreatePresented)
            }
            .accentColor(.primary)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
