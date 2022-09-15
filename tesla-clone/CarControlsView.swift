//
//  CarControlsView.swift
//  tesla-clone
//
//  Created by Silvanei  Martins on 14/09/22.
//

import SwiftUI

let carControls: [ActionItem] = [
    ActionItem(icon: "flashlight.on.fill", text: "Instantâneo"),
    ActionItem(icon: "speaker.wave.3.fill", text: "Buzina"),
    ActionItem(icon: "key.fill", text: "Começar"),
    ActionItem(icon: "arrow.up.bin", text: "Tronco Frontal"),
    ActionItem(icon: "arrow.up.square", text: "Porta-malas"),
]
    
struct CarControlsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var toggleValet: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            GeneralButton(icon: "chevron.left")
                        }
                        Spacer()
                    }
                    Text("Controle de Carro")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                CustomDivider()
                CarLockButton()
                CustomDivider()
                CarContrlsActions()
                HStack {
                    Text("Modo de Manobrista")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                    Spacer()
                    Toggle("", isOn: $toggleValet)
                }
                .padding()
            }
            .padding()
            if toggleValet {
                Text("O modo de manobrista está ativado!")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(Color.white)
        .navigationTitle("Controles de Carros")
        .navigationBarHidden(true)
    }
}

struct CarControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CarControlsView()
    }
}

struct CarLockButton: View {
    var body: some View {
        Button(action: {}) {
            FullButton(text: "Desbloquear Carro", icon: "lock.fill")
        }
    }
}

struct CarContrlsActions: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                ActionButton(item: carControls[0])
                Spacer()
                ActionButton(item: carControls[1])
                Spacer()
                ActionButton(item: carControls[2])
            }
            HStack {
                Spacer()
                ActionButton(item: carControls[3])
                Spacer()
                ActionButton(item: carControls[4])
                Spacer()
            }
        }
        .padding()
    }
}
