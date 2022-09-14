//
//  ContentView.swift
//  tesla-clone
//
//  Created by Silvanei  Martins on 14/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HomeHeader()
                    CustomDivider()
                    CarSection()
                    CustomDivider()
                    CategoryView(title: "Atalhos Rápidos", showEdit: true, actionItems: quickShortcuts)
                    CustomDivider()
                    CategoryView(title: "Ações Recentes", actionItems: recentActions)
                    CustomDivider()
                    AllSettings()
                    ReorderButton()
                }
                .padding()
            }
            VoiceCommandButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(Color.white)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Componentes da tela principal;

struct VoiceCommandButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
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

struct GeneralButton: View {
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 60, height: 60)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.4), lineWidth: 0.5)
            )
    }
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 0.5)
            .background(Color.white)
            .opacity(0.1)
    }
}

struct CarSection: View {
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Image(systemName: "battery.75")
                Text("280 Milhas".uppercased())
            }
            .foregroundColor(Color("Green"))
            .font(.system(size: 14, weight: .semibold, design: .rounded))
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
    var title: String
    var showEdit: Bool = false
    
    var actionItems: [ActionItem]
    
    var body: some View {
        VStack(spacing: 10) {
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(actionItems, id:\.self) { item in
                        ActionButton(item: item)
                    }
                }
            }
        }
    }
}

struct ActionButton: View {
    var item: ActionItem
    
    var body: some View {
        VStack(alignment: .center) {
            GeneralButton(icon: item.icon)
            Text(item.text)
                .frame(width: 75)
                .frame(height: 45)
                .font(.system(size: 12, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
        }
    }
}

struct ActionItem: Hashable {
    var icon: String
    var text: String
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Carregando"),
    ActionItem(icon: "fanblades.fill", text: "Ventidor Ligado"),
    ActionItem(icon: "music.note", text: "Controles de mídia"),
    ActionItem(icon: "bolt.car", text: "Porta de Alteração"),
]

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Abrir Tronco"),
    ActionItem(icon: "fanblades", text: "Ventidor Desligado"),
    ActionItem(icon: "person.fill.viewfinder", text: "Convocar")
]

struct AllSettings: View {
    var body: some View {
        CategoryHeader(title: "Configurações")
        LazyVGrid(columns: [GridItem(.fixed(190)), GridItem(.fixed(190))]) {
            SettingsBlock(icon: "car.fill", title: "Controles", subtitle: "Carro bloqueado")
            SettingsBlock(icon: "fanblades", title: "Climatização", subtitle: "Interior 68° F", backgroundColor: Color("Blue"))
            SettingsBlock(icon: "location.fill", title: "Localização", subtitle: "Edifício Empire State")
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
        HStack {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 17, weight: .medium, design: .default))
                
                Text(subtitle.uppercased())
                    .font(.system(size: 10, weight: .medium, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
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
