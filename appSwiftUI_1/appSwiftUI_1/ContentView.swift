//
//  ContentView.swift
//  appSwiftUI_1
//
//  Created by Michael Steve Espinoza Perez on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "globe").imageScale(.large).foregroundColor(.accentColor)
            Text("Hola Mundo").background(Color.blue)
            Text("Hi mundo").padding().background( Color.red)
            Text("Hola Mundo").padding(.vertical,50).background(Color.gray)
            Text("Es mi MAC!!!").padding(.init(top:50, leading: 30, bottom: 40, trailing: 20)).background(Color.green)
            
        }
        
        Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
        Text("To be, or not to be, that is the question:").frame(width: 100)
        
        Label(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/).padding([.top, .leading],21.0)
    }
    
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
