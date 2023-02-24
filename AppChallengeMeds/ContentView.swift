//
//  ContentView.swift
//  AppChallengeMeds
//
//  Created by AM Student on 10/7/22.
//

import SwiftUI

@available(iOS 15.0, *)

struct ContentView: View {
    @State private var showFirstSheet1 = false
    @State private var selectedDate = Date()
    @State private var alertIsVisible = false
    @State private var alertIsVisible1 = false
    @State private var typer = ""
    @State private var typer2 = ""
    
    @State var locations: [String] = []
    @Environment(\.dismiss) var dismiss
    
    let notify = NotificationHandler()
    
    private func onDelete(offsets: IndexSet) {
        
        locations.remove(atOffsets: offsets)
        
    }
    
        func addRow() {
           
            self.locations.append("\(typer), \(typer2). \n \(selectedDate)")
            
    }
    
    
    var body: some View {

        NavigationView {
            ZStack {
                VStack {
                    List {
                        
                        ForEach(locations, id: \.self ) { location in
                            Text(location)
                           
                            

                        }
                        .onDelete(perform: onDelete)
                    }
                    .background(Image("MedImage").resizable().frame(width: 300, height: 400))
                    .scrollContentBackground(.hidden)
                    
                    
                    .toolbarBackground(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)], startPoint: .topTrailing, endPoint: .bottomTrailing), for: .navigationBar)
                    
                    .toolbarBackground(.visible, for: .navigationBar)
                    
                    .navigationBarTitle(Text("Medications"))
                   
                    .navigationBarItems(trailing: Button(action: {
                        
                        self.showFirstSheet1 = true
                        
                    }) {
                        
                        Image(systemName: "plus")
                        
                    }
                                        //Sheet For Scheduling
                        .sheet(isPresented: $showFirstSheet1, content: {
                            
                            ZStack {
                                Color.white
                                LinearGradient(gradient: Gradient(colors: [Color.white, Color("Color").opacity(3.0)]), startPoint: .bottom, endPoint: .top)
                                    .ignoresSafeArea()
                                
                                VStack {
                                    
                                    Button(action: {
                                        showFirstSheet1 = false
                                        
                                    }) {
                                        
                                        Text("Done")
                                        
                                    }
                                    .offset(x: -150, y: 380)
                                    
                                    Spacer()
                                    ZStack {
                                        VStack {
                                            
                                            DatePicker("Pick a date:", selection: $selectedDate, in: Date()...)
                                                .fontWeight(.bold)
                                            
                                            HStack(alignment: .center) {
                                                
                                                Text("💊:")
                                                
                                                TextField("Medication", text: $typer)
                                                
                                                Text("# :")
                                                    .fontWeight(.bold)
                                                    .offset(x: 55)
                                                
                                                TextField("Dosage", text: $typer2)
                                                
                                                    .padding()
                                                    .offset(x: 40)
                                                
                                            }
                                            
                                        }
                                       
                                    }
                                    
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(.blue), lineWidth: 1))
                                    .padding()
                                    
                                    //Schedule Button
                                    
                                    Button(action: {
                                        
                                        notify.sendNotification(date: selectedDate,
                                                                
                                                                type: "date",
                                                                
                                                                title: "Medication Alert!",
                                                                
                                                                body: "It's time to take \(typer2)  of \(typer)!")
                                        
                                        addRow()
                                        
                                        alertIsVisible1 = true
                                        
                                        dismiss()
                                        
                                    }) {
                                        
                                        
                                        Text("Schedule Notification")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 25))
                                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                                            .shadow(color: .black, radius: 1, x: -1, y: -1)
                                            .padding(.horizontal, 10.0)
                                            .padding(.vertical, 10.0)
                                            .background(Color.blue)
                                            .cornerRadius(12)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("Color1"), lineWidth: 4))
                                        
                                    }
                                    
                                    .alert(isPresented: $alertIsVisible1, content: { let theMessage1 = String(self.alertIsVisible1)
                                        
                                        
                                        return Alert(title: Text("Notification has been scheduled!"))
                                        
                                    })
                                }
                                .offset(y: -350)
                                
                                VStack {
                                    
                                    Text("Not Working?")
                                        .foregroundColor(.gray)
                                        .padding()
                                    
                                    Button("Request Notifications") {
                                        
                                        notify.askPermission()
                                        
                                    }
                                }
                                .offset(y: 330)
                            }
                        })
                    )
                    
                }
                
                
                
            }
        }
        
    }
}



struct hither: View {
    var body: some View {
        Text("yes")

    }
}



struct Item: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    let imageName: String
}


@available(iOS 15.0, *)
private struct SheetContents: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button("Done") {
            dismiss()
        }
        .offset(x: 145, y: -338)
    }
}

struct Rradient: View {
    var body: some View {
        ZStack {
            Color.white
            LinearGradient(gradient: Gradient(colors: [Color.white, Color("Color").opacity(3.0)]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
        }
    }
}

struct ImageBack: View {
    var body: some View {
        ZStack {
            Image("MedImage")
                .resizable()
                .frame(width: 450, height: 900, alignment: .center)
                .ignoresSafeArea(.all)
        }
    }
}
