//
//  CommonComponents.swift
//  tesla-clone
//
//  Created by Silvanei  Martins on 14/09/22.
//

import Foundation
import SwiftUI

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

struct FullButton: View {
    
    var text: String
    var icon: String = ""
    
    var body: some View {
        if icon.isEmpty {
            textButton
        } else {
            iconButton
        }
    }
    
    var iconButton: some View {
        Label(text, systemImage: icon)
            .font(.system(size: 18, weight: .medium, design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
    
    var textButton: some View {
        Text(text)
            .font(.system(size: 18, weight: .medium, design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}
