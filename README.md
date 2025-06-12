# 🔍 Flutter XMAS Word Search

Este projeto Flutter implementa um sistema de **busca de palavras "XMAS"** dentro de uma matriz de letras (word search), com suporte a:

✅ Todas as direções (horizontal, vertical, diagonal)  
✅ Palavras invertidas e sobrepostas  
✅ Leitura de arquivo `.txt` da pasta `assets`  
✅ Interface visual com `GridView`  
✅ Processamento assíncrono com `Isolate` para evitar travar a UI  
✅ Gerenciamento de estado com `BLoC`

## 🧠 Como funciona

1. Ao clicar em **"Retorna total de XMAS"**, o app:
   - Lê o arquivo `input.txt` da pasta `assets`
   - Conta quantas vezes a palavra `XMAS` aparece

2. Ao clicar em **"Grid view de XMAS"**, o app:
   - Lê o arquivo `input.txt` da pasta `assets`
   - Converte o conteúdo em uma matriz (`List<String>`)
   - Envia essa matriz para uma função de busca rodando em um **Isolate**

3. Ao clicar em **"Grid view menor de XMAS"**, o app:
   - Lê o arquivo `menor_input.txt` da pasta `assets`
   - Converte o conteúdo em uma matriz (`List<String>`)
   - Envia essa matriz para uma função de busca rodando em um **Isolate**

4. O algoritmo de busca:
   - Percorre cada célula da matriz
   - Tenta formar a palavra `"XMAS"` em todas as 8 direções
   - Verifica limites da matriz e compara letra por letra
   - Marca todas as ocorrências encontradas

5. O resultado:
   - Mostra o número total de ocorrências
   - Exibe a matriz visualmente, com `"XMAS"` preservado e outros caracteres substituídos por `"."`

---

## 🔧 Tecnologias utilizadas

- **Flutter**
- **Dart**
- **BLoC (flutter_bloc)**
- **Isolate**
- **Assets (rootBundle)**
- **GridView**

---

## 🖼️ Exemplo visual (matriz simplificada)

**"Entrada"**
   - M M M S X X M A S M
   - M S A M X M S M S A
   - A M X S X M A A M M
   - M S A M A S M S M X
   - X M A S A M X A M M
   - X X A M M X X A M A
   - S M S M S A S X S S
   - S A X A M A S A A A
   - M A M M M X M M M M
   - M X M X A X M A S X

**"Saída"**
   - . . . . X X M A S .
   - . S A M X M S . . .
   - . . . S . . A . . .
   - . . A . A . M S . X
   - X M A S A M X . M M
   - X . . . . . X A . A
   - S . S . S . S . S S
   - . A . A . A . A . A
   - . . M . M . M . M M
   - . X . X . X M A S X
