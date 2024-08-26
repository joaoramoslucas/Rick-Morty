//
//  Home.swift
//  Rick
//
//  Created by Jao on 21/08/24.
//
import SwiftUI

struct Home: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @State private var pulsate = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Carregando personagens...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.onErr {
                    Text("Erro ao carregar personagens.")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.characters) { char in
                                NavigationLink(destination: CharacterDetail(character: char)) {
                                    VStack {
                                        if let imageUrl = char.image, let url = URL(string: imageUrl) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 150, height: 150)
                                                    .clipped()
                                                    .modifier(PulsatingEffect())
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 150, height: 150)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(10)
                                            }
                                        } else {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(10)
                                        }
                                        Text(char.name)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.white.opacity(0.7))
                                            .cornerRadius(4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Personagens")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getCharacters()
            }
        }
    }
}

struct PulsatingEffect: ViewModifier {
    @State private var pulsate = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(pulsate ? 1.0 : 1.1)
            .animation(
                Animation.easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: true),
                value: pulsate
            )
            .onAppear {
                pulsate = true
            }
    }
}

// Preview da tela Home
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
