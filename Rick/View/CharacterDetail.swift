import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) { // Aumenta o espaçamento entre os elementos
                // Centralizar o conteúdo
                VStack {
                    // Imagem do personagem com borda e sombra
                    if let imageUrl = character.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2))
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.bottom, 20) // Aumenta o espaçamento abaixo da imagem
                    }
                    
                    // Nome do personagem com estilo aprimorado
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.bottom, 5)
                }
                
                // Detalhes do personagem centralizados com borda e fundo
                VStack(alignment: .leading, spacing: 15) {
                    Text("Status: \(character.status ?? "Desconhecido")")
                    Text("Espécie: \(character.specie ?? "Desconhecido")")
                    Text("Gênero: \(character.gender)")
                    Text("Origem: \(character.origin.name)")
                }
                .font(.title3)
                .foregroundColor(.secondary)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .frame(maxWidth: .infinity) // Para ocupar toda a largura possível
                .shadow(radius: 5) // Adiciona sombra para destacar a caixa de detalhes
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center) // Centraliza todo o conteúdo
            .background(Color(.systemBackground))
        }
        .navigationTitle("Detalhes do Personagem") // Adiciona um título à tela
        .navigationBarTitleDisplayMode(.inline) // Exibe o título no modo compacto
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
            .preferredColorScheme(.light) // Adiciona visualização em modo claro
            .previewLayout(.sizeThatFits) // Ajusta o layout da pré-visualização
    }
}
