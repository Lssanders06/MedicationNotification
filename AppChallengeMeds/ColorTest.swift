//
//  ColorTest.swift
//  AppChallengeMeds
//
//  Created by AM Student on 10/11/22.
//

import SwiftUI

struct ColorTest: View {
    var body: some View {
            NavigationView {
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.orange.opacity(0.2))
                    
                    ScrollView {
                        ForEach(0 ..< 15) { item in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)], startPoint: .topTrailing, endPoint: .bottomTrailing))
                                .frame(height: 44)
                                .padding()
                        }
                    }
                }
                .navigationTitle("List & NavView")
            }
        }
    }
            
struct ColorTest_Previews: PreviewProvider {
    static var previews: some View {
        ColorTest()
    }
}
