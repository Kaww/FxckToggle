//
//  FxckToggle.swift
//  FxckToggle
//
//  Created by KAWRANTIN LE GOFF on 24/09/2021.
//

import SwiftUI

struct FxckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.system(size: 18, weight: .medium, design: .rounded))
            
            Spacer()
            
            FxckToggleStyleBody(isOn: configuration.$isOn)
        }
    }
}

private struct FxckToggleStyleBody: View {
    
    public enum PressedState {
        case pressed
        case notPressed
    }
    
    @Binding var isOn: Bool
    @GestureState private var isPressed = false
    
    var body: some View {
        ZStack {
            background
            
            image
                .scaleEffect(isPressed ? 0.9 : 1)
                .rotationEffect(
                    isPressed
                    ? isOn ? .degrees(10) : .degrees(-10)
                    : .degrees(0)
                )
                .animation(.spring(), value: isPressed)
                .opacity(isOn ? 1 : 0)
                .rotationEffect(
                    isOn
                    ? .degrees(0)
                    : .degrees(-180)
                )
                .offset(x: isOn ? 15 : -15)
            
            image
                .scaleEffect(isPressed ? 0.9 : 1)
                .rotationEffect(
                    isPressed
                    ? isOn ? .degrees(10) : .degrees(-10)
                    : .degrees(0)
                )
                .animation(.spring(), value: isPressed)
                .opacity(isOn ? 0 : 1)
                .rotationEffect(
                    isOn
                    ? .degrees(180)
                    : .degrees(0)
                )
                .offset(x: isOn ? 15 : -15)
        }
        .contentShape(Rectangle())
        .gesture(toggleTapGesture)
    }
    
    private var image: some View {
        ZStack {
            Image("thumbup")
                .resizable()
                .frame(width: 38, height: 38)
                .opacity(isOn ? 1 : 0)
            
            Image("fxckyou")
                .resizable()
                .frame(width: 38, height: 38)
                .opacity(isOn ? 0 : 1)
        }
        .shadow(
            color: .black.opacity(isPressed ? 0.4 : 0.2),
            radius: isPressed ? 4 : 5,
            x: 0, y: 0
        )
    }
    
    private var background: some View {
        Capsule(style: .continuous)
            .fill(isOn ? Color("FxckToggleON") : Color("FxckToggleOFF"))
            .frame(width: 50, height: 20)
            .offset(y: 5)
            .scaleEffect(isPressed ? 1.1 : 1)
            .animation(.spring(), value: isPressed)
    }
    
    private var toggleTapGesture: _EndedGesture<GestureStateGesture<DragGesture, Bool>> {
        DragGesture(minimumDistance: 0)
            .updating($isPressed) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onEnded { _ in
                toggle()
            }
    }
    
    private func toggle() {
        withAnimation(.spring()) {
            self.isOn.toggle()
        }
    }
}

struct FxckToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Toggle("Toggle is ON", isOn: .constant(true))
                .toggleStyle(FxckToggleStyle())
            
            Toggle("Toggle is OFF", isOn: .constant(false))
                .toggleStyle(FxckToggleStyle())
            
            Toggle("I'm the normal Toggle", isOn: .constant(true))
        }
        .padding(.horizontal)
    }
}
