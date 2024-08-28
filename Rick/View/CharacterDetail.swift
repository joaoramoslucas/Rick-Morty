import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagem do personagem com borda e sombra
                if let imageUrl = character.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2))
                            .shadow(radius: 5)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 10)
                }
                
                // Nome do personagem com estilo aprimorado
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                
                // Detalhes do personagem com espaçamento melhorado
                VStack(alignment: .leading, spacing: 8) {
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
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
        }
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
    }
}
