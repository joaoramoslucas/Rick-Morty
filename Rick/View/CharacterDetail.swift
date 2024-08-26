import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Imagem do personagem
                if let imageUrl = character.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                // Nome do personagem
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                
                // Detalhes do personagem
                VStack(alignment: .leading, spacing: 5) {
                    Text("Status: \(character.status ?? "Desconhecido")")
                    Text("Espécie: \(character.specie ?? "Desconhecido")")
                    Text("Gênero: \(character.gender)")
                    Text("Origem: \(character.origin.name)")
                }
                .font(.title3)
                
                Spacer()
            }
            .padding()
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
    }
}
