//
//  RickApp.swift
//  Rick
//
//  Created by Jao on 21/08/24.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewModel = HomeViewModel() // Observa mudanças no ViewModel para atualizar a UI

    // Configuração das colunas para o LazyVGrid
    private let columns = [
        GridItem(.flexible(), spacing: 16), // Coluna flexível com espaçamento de 16 pontos
        GridItem(.flexible(), spacing: 16)  // Outra coluna flexível com o mesmo espaçamento
    ]
    
    @State private var pulsate = false // Estado para controlar o efeito de pulsação

    var body: some View {
        NavigationView { // Cria uma view de navegação
            Group { // Agrupa diferentes estados de exibição
                if viewModel.isLoading {
                    // Mostra um indicador de progresso quando os dados estão carregando
                    ProgressView("Carregando personagens...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Centraliza o indicador
                } else if viewModel.onErr {
                    // Exibe uma mensagem de erro se ocorrer um problema ao carregar os personagens
                    Text("Erro ao carregar personagens.")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Centraliza a mensagem
                        .padding()
                } else {
                    // Exibe os personagens em uma grade quando os dados são carregados com sucesso
                    ScrollView { // Permite rolar o conteúdo verticalmente
                        LazyVGrid(columns: columns, spacing: 16) { // Cria uma grade flexível de duas colunas
                            ForEach(viewModel.characters) { char in // Itera sobre a lista de personagens
                                NavigationLink(destination: CharacterDetail(character: char)) { // Link para a tela de detalhes do personagem
                                    VStack { // Empilha verticalmente a imagem e o nome do personagem
                                        if let imageUrl = char.image, let url = URL(string: imageUrl) {
                                            AsyncImage(url: url) { image in // Carrega a imagem de forma assíncrona
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 150, height: 150) // Define o tamanho da imagem
                                                    .clipped() // Corta a imagem para ajustar ao frame
                                                    .modifier(PulsatingEffect()) // Aplica o efeito de pulsação
                                            } placeholder: {
                                                ProgressView() // Indicador de progresso enquanto a imagem carrega
                                                    .frame(width: 150, height: 150)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(10) // Borda arredondada para o placeholder
                                            }
                                        } else {
                                            Rectangle() // Exibe um retângulo cinza caso a imagem não esteja disponível
                                                .fill(Color.gray)
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(10)
                                        }
                                        Text(char.name) // Exibe o nome do personagem
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.white.opacity(0.7)) // Fundo semitransparente para o texto
                                            .cornerRadius(4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.1)) // Fundo cinza claro para a célula do personagem
                                    .cornerRadius(10) // Borda arredondada para a célula do personagem
                                    .shadow(radius: 5) // Sombra para a célula do personagem
                                }
                            }
                        }
                        .padding() // Adiciona espaçamento ao redor da grade
                    }
                }
            }
            .navigationTitle("Personagens") // Título da barra de navegação
            .navigationBarTitleDisplayMode(.inline) // Exibe o título no modo compacto
            .onAppear {
                viewModel.getCharacters() // Chama o método para carregar os personagens ao aparecer a view
            }
        }
    }
}

struct PulsatingEffect: ViewModifier { // Modificador de view para o efeito de pulsação
    @State private var pulsate = false // Estado para controlar a animação de pulsação

    func body(content: Content) -> some View {
        content
            .scaleEffect(pulsate ? 1.0 : 1.1) // Alterna o tamanho da view para criar o efeito de pulsação
            .animation(
                Animation.easeInOut(duration: 2.5) // Animação suave que dura 2.5 segundos
                    .repeatForever(autoreverses: true), // Repetição infinita da animação, revertendo a escala
                value: pulsate
            )
            .onAppear {
                pulsate = true // Ativa a animação ao aparecer a view
            }
    }
}

// Preview da tela Home
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home() // Exibe a preview da tela Home
    }
}
