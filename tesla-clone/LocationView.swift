//
//  LocationView.swift
//  tesla-clone
//
//  Created by Silvanei  Martins on 14/09/22.
//

import SwiftUI
import MapKit

struct CarLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let carLocations = [CarLocation(latitude: -12.748745, longitude: -60.150966)]

struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -12.748745, longitude: -60.150966), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $location, annotationItems: carLocations, annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate, content: {CarPin()})
            })
            CarLocationPanel()
            LinearGradient(gradient: Gradient(colors: [Color("DarkGray"), Color.clear, Color.clear]), startPoint: .top, endPoint: .bottom)
                .allowsHitTesting(false)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        GeneralButton(icon: "chevron.left")
                    }
                    Spacer()
                    Button(action: {}) {
                        GeneralButton(icon: "speaker.wave.3.fill")
                    }
                }
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(Color.white)
        .navigationTitle("Controles de Carros")
        .navigationBarHidden(true)
    }
}

struct CarPin: View {
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Image(systemName: "car.fill")
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color("Red").opacity(0.7))
                .foregroundColor(Color.white)
                .clipShape(Circle())
            Text("Mach Five")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color("Red").opacity(0.3), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .foregroundColor(Color.black)
                .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(Color.black.opacity(0.1), lineWidth: 1))
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

struct CarLocationPanel: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Localização")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    CustomDivider()
                    Label("23 W 15 TH ST, VILHENA, RO, BR 10001", systemImage: "location.fill")
                        .opacity(0.5)
                        .font(.footnote)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Convocar")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Pressione e segure os controles para mover o veículo")
                            .opacity(0.5)
                            .font(.footnote)
                    }
                    CustomDivider()
                    FullButton(text: "Ir para o destino")
                    HStack{
                        FullButton(text: "Avançar", icon: "arrow.up")
                        FullButton(text: "Voltar", icon: "arrow.down")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(Color.white)
        }
    }
}
