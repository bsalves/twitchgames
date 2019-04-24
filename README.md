# Twitch Games

Este app exibe os games mais jogados pelos usuários da Twitch TV

### Configuração do projeto

Este projeto contem componentes do CocoaPods, por isso é importante que a gem do CocoaPods esteja instalado.

Após baixar o projeto, é necessário executar o comando de instalação dos pods dentro do diretório do projeto:

```sh
$ pod install
```

Após instalado as dependências do CocoaPods, o projeto esta apto para ser executado.

### Features

 - Listagem de jogos mais jogados e transmitidos na TwitchTV
 - Tela com detalhes de quantos canais ativos no momento e quantos espectadores do jogo
 - Video com um video aleatório de alguma gameplay ou algum acontecimento envolvendo o jogo

### Navegação

Quando aberto pela primeira vez, o app ira listar os jogos e ao clicar em um determinado jogo você será direcionado para a pagina de detalhes do jogo, onde ira exibir informações sobre quantos canais ativos e espectadores no momento. Na tela de detalhes existe um botão que ao ser pressionado ira abrir um videoclip aleatório sobre o jogo.

### Persistencia de dados

Por se tratar de um app que lista os jogos mais jogados no momento a listagem de jogos a lista é persistida para gerar cache da última sincronização, também utilizei um componente que serve para persistir imagem como cache, assim, uma vez carregado a listagem de jogos o usuário pode navegar para as telas seguintes.
