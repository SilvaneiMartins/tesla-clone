//
//  ContentView.swift
//  tesla-clone
//
//  Created by Silvanei  Martins on 14/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var openVoiceCommand = false
    @State private var openMedia = false
    @State private var openCharging = false
    
    @State private var actionText = ""
    @State private var actionIcon = ""
    @State private var openAction = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        HomeHeader()
                        CustomDivider()
                        CarSection(openCharging: $openCharging)
                        CustomDivider()
                        CategoryView(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon, openCharging: $openCharging, openMedia: $openMedia, title: "Atalhos Rápidos", showEdit: true, actionItems: quickShortcuts)
                        CustomDivider()
                        CategoryView(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon, openCharging: $openCharging, openMedia: $openMedia, title: "Ações Recentes", actionItems: recentActions)
                        CustomDivider()
                        AllSettings()
                        ReorderButton()
                    }
                    .padding()
                }
                VoiceCommandButton(open: $openVoiceCommand)
                
                if (openVoiceCommand || openCharging || openMedia || openAction) {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openVoiceCommand = false
                                openCharging = false
                                openMedia = false
                                openAction = false
                            }
                        }
                }
                
                if openVoiceCommand {
                    VoiceCommandView(open: $openVoiceCommand, text: "Leve-me para Silvanei Martins")
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openCharging {
                    ChargingView()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openMedia {
                    MediaPlayer()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openAction && !actionText.isEmpty {
                    ActionNotification(open: $openAction, icon: actionIcon, text: actionText)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(Color.white)
            .navigationTitle("Mach Five")
            .navigationBarHidden(true)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Componentes da tela principal;

struct VoiceCommandButton: View {
    
    @Binding var open: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        open = true
                    }
                }) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .frame(width: 64, height: 64)
                        .background(Color("Green"))
                        .foregroundColor(Color("DarkGray"))
                        .clipShape(Circle())
                        .padding()
                        .shadow(radius: 10)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Modelo 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack {
                Button(action: {}) {
                    GeneralButton(icon: "lock.fill")
                }
                
                Button(action: {}) {
                    GeneralButton(icon: "gear")
                }
            }
        }
    }
}

struct CarSection: View {
    
    @Binding var openCharging: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                openCharging = true
            }) {
                Label("237 Milhas".uppercased(), systemImage: "battery.75")
                    .foregroundColor(Color("Green"))
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Estacionado")
                    .fontWeight(.semibold)
                Text("Ultima atualização: 5 minuto atrás")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        Image("carro")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct CategoryHeader: View {
    var title: String
    var showEdit: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                if showEdit {
                    Button(action: {}) {
                        Text("Editar")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
}

struct CategoryView: View {
    
    @Binding var openAction: Bool
    @Binding var actionText: String
    @Binding var actionIcon: String
    
    @Binding var openCharging: Bool
    @Binding var openMedia: Bool
    
    var title: String
    var showEdit: Bool = false
    
    var actionItems: [ActionItem]
    
    var body: some View {
        VStack(spacing: 10) {
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    if title == "Atalhos Rápidos" {
                        Button(action: {
                            withAnimation {
                                openCharging = true
                            }
                        }) {
                            ActionButton(item: chargingShortCut)
                        }
                        Button(action: {
                            withAnimation {
                                openMedia = true
                            }
                        }) {
                            ActionButton(item: mediaShortCut)
                        }
                    }
                    
                    ForEach(actionItems, id:\.self) { item in
                        Button(action: {
                            withAnimation{
                                openAction = true
                                actionText = item.text
                                actionIcon = item.icon
                            }
                        }) {
                            ActionButton(item: item)
                        }
                    }
                }
            }
        }
    }
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "fanblades.fill", text: "Ventidor Ligado"),
    ActionItem(icon: "bolt.car", text: "Porta de Alteração"),
]

let chargingShortCut =
ActionItem(icon: "bolt.fill", text: "Carregando")
let mediaShortCut =
ActionItem(icon: "music.note", text: "Controles de mídia")

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Abrir Tronco"),
    ActionItem(icon: "fanblades", text: "Ventidor Desligado"),
    ActionItem(icon: "person.fill.viewfinder", text: "Convocar")
]

struct AllSettings: View {
    var body: some View {
        CategoryHeader(title: "Configurações")
        LazyVGrid(columns: [GridItem(.fixed(190)), GridItem(.fixed(190))]) {
            NavigationLink(destination: CarControlsView()) {
                SettingsBlock(icon: "car.fill", title: "Controles", subtitle: "Carro bloqueado")
            }
            SettingsBlock(icon: "fanblades", title: "Climatização", subtitle: "Interior 68° F", backgroundColor: Color("Blue"))
            NavigationLink(destination: LocationView()) {
                SettingsBlock(icon: "location.fill", title: "Localização", subtitle: "Edifício Empire State")
            }
            SettingsBlock(icon: "checkerboard.shield", title: "Seguraça", subtitle: "0 Eventos detectados")
            SettingsBlock(icon: "sparkles", title: "Atualização", subtitle: "3 Atualizações disponíveis")
        }
    }
}

struct SettingsBlock: View {
    var icon: String
    var title: String
    var subtitle: String
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 14, weight: .medium, design: .default))
                
                Text(subtitle.uppercased())
                    .font(.system(size: 8, weight: .medium, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            .padding(.leading, 8)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 20)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}

struct ReorderButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Reordenar Grupos")
                .font(.caption)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
