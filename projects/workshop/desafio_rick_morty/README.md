# Rick and Morty App

Um aplicativo Flutter que consome a API do Rick and Morty para exibir informações sobre personagens da série, com funcionalidade de favoritos e navegação intuitiva.

## 📱 Funcionalidades

- **Listagem de Personagens**: Visualize todos os personagens da série Rick and Morty
- **Detalhes do Personagem**: Acesse informações completas como status, espécie, gênero, origem e localização
- **Sistema de Favoritos**: Adicione/remova personagens dos favoritos com persistência local
- **Navegação Intuitiva**: Interface limpa com navegação fluida entre telas

## 🏗️ Arquitetura e Padrões

### Arquitetura Escolhida
O projeto segue uma **arquitetura em camadas** com separação clara de responsabilidades:

- **Presentation Layer** (`pages/` e `components/`): Responsável pela interface do usuário
- **Business Logic Layer** (`data/`): Gerencia regras de negócio e operações
- **Data Layer** (`models/`): Define estruturas de dados e modelos
- **Theme Layer** (`theme/`): Centraliza recursos visuais e estilização

### Padrões de Design Implementados

#### 1. **Repository Pattern**
- **Arquivo**: `data/repository.dart`
- **Propósito**: Abstrai o acesso aos dados da API, centralizando todas as operações de rede
- **Benefício**: Facilita testes e manutenção, isolando a lógica de acesso a dados

#### 2. **Singleton Pattern**
- **Arquivo**: `data/favorites_manager.dart`
- **Propósito**: Garante uma única instância para gerenciamento de favoritos
- **Benefício**: Consistência de dados e economia de recursos

#### 3. **Component-Based Architecture**
- **Arquivos**: `components/` e `widgets/`
- **Propósito**: Reutilização de componentes UI em diferentes telas
- **Benefício**: Manutenibilidade e consistência visual

#### 4. **Model-View Pattern**
- **Models**: Definem estrutura de dados (`DetailedCharacter`, `Character`, `Episode`)
- **Views**: Páginas que apresentam os dados (`HomePage`, `DetailsPage`, `FavoritesPage`)
- **Benefício**: Separação clara entre dados e apresentação

### Decisões Arquiteturais

#### **Gerenciamento de Estado**
- **Abordagem**: StatefulWidget com setState()
- **Justificativa**: Simplicidade adequada para o escopo do projeto

#### **Persistência de Dados**
- **Solução**: SharedPreferences para favoritos
- **Justificativa**: Dados simples que não requerem banco de dados complexo
- **Formato**: JSON serialization para objetos DetailedCharacter

#### **Consumo de API**
- **Biblioteca**: HTTP nativo do Dart
- **Padrão**: Async/await para operações assíncronas

#### **Navegação**
- **Estrutura**: Rotas centralizadas no main.dart
- **Benefício**: Navegação previsível e fácil manutenção

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework principal para desenvolvimento mobile
- **Dart**: Linguagem de programação
- **HTTP**: Consumo da API REST do Rick and Morty
- **SharedPreferences**: Armazenamento local dos favoritos
- **Google Fonts**: Tipografia personalizada (Lato)



## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

### Instalação

1. Clone o repositório:
\`\`\`bash
git clone <https://github.com/LaviniaBDantas/kode-start.git>
cd desafio_rick_morty
\`\`\`

2. Instale as dependências:
\`\`\`bash
flutter pub get
\`\`\`

3. Execute o aplicativo:
\`\`\`bash
flutter run
\`\`\`



## 🔗 API

O aplicativo consome a [Rick and Morty API](https://rickandmortyapi.com/):
- **Endpoint de personagens**: `https://rickandmortyapi.com/api/character`
- **Paginação automática** para carregar todos os personagens
- **Detalhes completos** de cada personagem incluindo episódios

## 📱 Telas

1. **Home**: Lista todos os personagens em cards compactos
2. **Detalhes**: Exibe informações completas do personagem 
3. **Favoritos**: Lista personagens salvos como favoritos


---

Desenvolvido com ❤️ usando Flutter
