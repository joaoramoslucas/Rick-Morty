//
//  RickApp.swift
//  Rick
//
//  Created by Jao on 21/08/24.
//

import SwiftUI

struct CharacterDetail: View {
    var character: Character // Propriedade para armazenar o personagem atual a ser exibido
    
    var body: some View {
        ScrollView { // Permite que o conteúdo role verticalmente se necessário
            VStack(spacing: 30) { // Empilha os elementos verticalmente com um espaçamento maior entre eles
                // Centraliza o conteúdo dentro de uma VStack
                VStack {
                    // Verifica se a URL da imagem é válida
                    if let imageUrl = character.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in // Carrega a imagem de forma assíncrona
                            image
                                .resizable()
                                .scaledToFit() // Ajusta a imagem mantendo a proporção
                                .frame(maxHeight: 250) // Limita a altura máxima da imagem
                                .clipShape(RoundedRectangle(cornerRadius: 15)) // Aplica um corte arredondado na imagem
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2)) // Adiciona uma borda cinza
                                .shadow(radius: 5) // Aplica uma sombra à imagem para destacá-la
                        } placeholder: {
                            ProgressView() // Exibe um indicador de progresso enquanto a imagem carrega
                        }
                        .padding(.bottom, 20) // Adiciona espaçamento abaixo da imagem para separação visual
                    }

                    // Exibe o nome do personagem com estilo de fonte grande e negrito
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary) // Cor do texto primária que adapta ao modo escuro/claro
                        .padding(.bottom, 5) // Adiciona espaçamento abaixo do nome
                }
                
                // Exibe os detalhes do personagem em uma caixa com borda e fundo
                VStack(alignment: .leading, spacing: 15) { // Alinhamento à esquerda com espaçamento aumentado
                    Text("Status: \(character.status ?? "Desconhecido")") // Exibe o status do personagem ou "Desconhecido" se for nulo
                    Text("Espécie: \(character.specie ?? "Desconhecido")") // Exibe a espécie do personagem ou "Desconhecido"
                    Text("Gênero: \(character.gender)") // Exibe o gênero do personagem
                    Text("Origem: \(character.origin.name)") // Exibe a origem do personagem
                }
                .font(.title3) // Define o estilo de fonte para os detalhes
                .foregroundColor(.secondary) // Define uma cor secundária para o texto
                .padding() // Adiciona preenchimento ao redor da caixa de detalhes
                .background(Color(.systemGray6)) // Define um fundo cinza claro para a caixa de detalhes
                .cornerRadius(10) // Arredonda os cantos da caixa de detalhes
                .frame(maxWidth: .infinity) // Permite que a caixa de detalhes ocupe toda a largura disponível
                .shadow(radius: 5) // Adiciona uma sombra à caixa de detalhes para destaque visual
                
                Spacer() // Empurra o conteúdo para o topo, deixando espaço no final
            }
            .padding(.horizontal) // Adiciona preenchimento horizontal ao conteúdo da ScrollView
            .frame(maxWidth: .infinity, alignment: .center) // Centraliza todo o conteúdo horizontalmente
            .background(Color(.systemBackground)) // Define o fundo da ScrollView conforme o tema do sistema
        }
        .navigationTitle("Detalhes do Personagem") // Adiciona um título à barra de navegação
        .navigationBarTitleDisplayMode(.inline) // Exibe o título da barra de navegação no modo compacto
    }
}

// Preview da tela de detalhes
struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCharacter = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            specie: "Human",
            type: nil,
            gender: "Male",
            origin: OriginConfig(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            url: "",
            created: ""
        )
        CharacterDetail(character: exampleCharacter)
            .preferredColorScheme(.light) // Adiciona visualização em modo claro para a prévia
            .previewLayout(.sizeThatFits) // Ajusta o layout da pré-visualização para caber no tamanho de conteúdo
    }
}
