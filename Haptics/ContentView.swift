//
//  ContentView.swift
//  Haptics
//
//  Created by Antoine Raulin on 11/06/2020.
//  Copyright © 2020 Antoine Raulin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var mode = 0
    @State private var intensity:CGFloat = 1.0
    @State private var style = 0
    @Environment(\.colorScheme) var colorScheme
    @State private var name = "Impact"
    
    
    
    var body: some View {
        let mode2 = Binding<Int>(get: {

            return self.mode

        }, set: {
            self.style = 0
            self.mode = $0
            print("mode changed");
            switch $0 {
            case 0:
                self.name = "Impact"
            case 1:
                self.name = "Selection"
            case 2:
                self.name = "Notification"
            default:
                self.name = ""
            }
            
            

        })
        return NavigationView {
            VStack(alignment: .leading){
                
                Picker(selection: mode2, label: Text("Mode")) {
                    Text("Impact").tag(0)
                    Text("Selection").tag(1)
                    Text("Notification").tag(2)
                    }.pickerStyle(SegmentedPickerStyle()).padding()
                if self.mode != 1 {
                if self.mode == 0 {
                HStack {
                    Text("Intensité :").bold()
                    Text("\(intensity, specifier: "%.1f")")
                }.padding()
                HStack {
                    Text("0")
                    Slider(value: $intensity, in: 0.0...1.0, step: 0.1)
                    Text("1")
                }.padding(.horizontal).padding(.top, -20)
                }
                Text("Style").bold().padding()
                HStack {
                    Button(action: {
                        self.style = 0;
                        
                    }) {
                        Text(self.mode == 0 ? "Heavy":"Error").frame(maxWidth: .infinity).padding().background((style == 0 ? Color.blue :( colorScheme == .light ? Color(.systemGray5):Color(.systemGray6) ))).accentColor((style == 0 ? .white : (colorScheme == .light ?.black: .white))).cornerRadius(5)
                    }
                    Button(action: {
                        self.style = 1;
                    }) {
                        Text(self.mode == 0 ? "Light":"Success").frame(maxWidth: .infinity).padding().background((style == 1 ? Color.blue :( colorScheme == .light ? Color(.systemGray5):Color(.systemGray6) ))).accentColor((style == 1 ? .white : (colorScheme == .light ?.black: .white))).cornerRadius(5)
                    }
                }.padding().padding(.top, -20)
                HStack {
                    Button(action: {
                        self.style = 2;
                        
                    }) {
                        Text(self.mode == 0 ? "Medium":"Warning").frame(maxWidth: .infinity).padding().background((style == 2 ? Color.blue :( colorScheme == .light ? Color(.systemGray5):Color(.systemGray6) ))).accentColor((style == 2 ? .white : (colorScheme == .light ?.black: .white))).cornerRadius(5)
                    }
                    Button(action: {
                        self.style = 3;
                    }) {
                        if self.mode == 0 {
                            Text("Rigid").frame(maxWidth: .infinity).padding().background((style == 3 ? Color.blue :( colorScheme == .light ? Color(.systemGray5):Color(.systemGray6) ))).accentColor((style == 3 ? .white : (colorScheme == .light ?.black: .white))).cornerRadius(5)
                        }else{
                            Text("").frame(maxWidth: .infinity).padding()
                        }
                        
                    }
                }.padding().padding(.top, -22)
                HStack {
                    Button(action: {
                        self.style = 4;
                        
                    }) {
                        if self.mode == 0{
                        Text("Soft").frame(maxWidth: .infinity).padding().background((style == 4 ? Color.blue :( colorScheme == .light ? Color(.systemGray5):Color(.systemGray6) ))).accentColor((style == 4 ? .white : (colorScheme == .light ?.black: .white))).cornerRadius(5)
                        }else{
                            Text("").frame(maxWidth: .infinity).padding()
                        }
                    }
                    Button(action: {
                        
                    }) {
                        
                        Text("").frame(maxWidth: .infinity).padding()
                    }
                }.padding().padding(.top, -22)
                }else{
                    Image(systemName: "gear").resizable()
                    .frame(width: 32.0, height: 32.0).frame(maxWidth:.infinity).padding(.top, 50)
                    Text("Il n'y a rien à configurer").frame(maxWidth: .infinity).padding()
                }
                Spacer()
                Button(action: {
                    if self.mode == 0 {
                        var hapticStyle:UIImpactFeedbackGenerator.FeedbackStyle = .heavy
                        switch self.style {
                        case 0:
                            hapticStyle = .heavy
                        case 1:
                            hapticStyle = .light
                        case 2:
                            hapticStyle = .medium
                        case 3:
                            hapticStyle = .rigid
                        case 4:
                            hapticStyle = .soft
                        default:
                            hapticStyle = .heavy
                        }
                        let haptic = UIImpactFeedbackGenerator(style:hapticStyle)
                        haptic.impactOccurred(intensity: self.intensity)
                        
                    }
                    else if self.mode == 1 {
                        let haptic = UISelectionFeedbackGenerator();
                        haptic.selectionChanged()
                    }
                    else if self.mode == 2 {
                        var hapticStyle:UINotificationFeedbackGenerator.FeedbackType = .error
                        switch self.style {
                        case 0:
                            hapticStyle = .error
                        case 1:
                            hapticStyle = .success
                        case 2:
                            hapticStyle = .warning
                        default:
                            hapticStyle = .error
                        }
                        let haptic = UINotificationFeedbackGenerator()
                        haptic.notificationOccurred(hapticStyle)
                    }
                }) {
                    
                    Text("Simuler \(self.name)").frame(maxWidth: .infinity).padding().background(Color.blue).accentColor(.white).cornerRadius(5)
                }.padding()
            }.navigationBarTitle(Text("Haptics"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           ContentView()
            .environment(\.colorScheme, .dark)
        }
        
    }
}
