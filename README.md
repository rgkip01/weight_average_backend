# WEIGHT AVERAGE SERVICE

Esta é uma API para gerenciar projetos e suas avaliações, calculando médias ponderadas e totais.

## Funcionalidade
- Cadastro e Listagem de Projetos: Permite criar novos projetos e listar todos os projetos existentes, com suporte a paginação para lidar com grande quantidade de dados.

- Cadastro de Avaliações: Aceita o registro de avaliações para os projetos, incluindo múltiplas notas associadas a critérios previamente definidos.

- Cálculo de Médias: Automatiza o cálculo da média ponderada para cada avaliação com base nas notas e pesos dos critérios, e também calcula a média total do projeto a partir das avaliações.

- Cadastro e Atualização de Critérios: Possibilita a criação e atualização de critérios de avaliação, que são elementos centrais no cálculo das médias ponderadas.

- Consistência de Dados: Garante a integridade e a consistência dos dados, recalculando as médias sempre que há atualizações nos critérios ou nas notas.

- Paginação de Resultados: Implementa a paginação nas listagens de projetos para otimizar a performance e a usabilidade da API, especialmente em cenários com grande volume de dados.

---

## Configuração e Execução da API com Docker Compose
### Pré-requisitos

- Docker
- Docker Compose

Certifique-se de ter o Docker e o Docker Compose instalados.
- Links para instalação simples:
[Instalando do Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)

[Instalando o Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-pt)

---
### Instruções de Configuração

1. **Clone o Repositório**:

`git clone git@github.com:rgkip01/weight_average_backend.git`

`cd prosas_weight_average_backend`

2. **Execute o Script de Setup**:
Este projeto inclui um script chamado `setup_project.sh` que automatiza o processo de construção e configuração do projeto.

**Obs: Esse step leva um pouquinho mais de tempo, pois ele irá popular a base com os 1000 projetos conforme esperado** 

`chmod +x setup_project.sh`

`sh setup_project.sh`


Este script realiza as seguintes ações:
- Limpa imagens Docker existentes e containers ativos.
- Constrói os containers Docker Compose.
- Cria e configura o banco de dados.
- Gera dados de teste.
- Inicia a aplicação.


## Utilização da API

Agora com a API rodando utilize uma IDE de serviço HTTP
como por exemplo, o Postman para executar as requests


A API oferece os seguintes endpoints:

### POST /projetos

Cria ou atualiza um projeto com suas avaliações e notas.

Exemplo da request: `http://localhost:3000/v1/projetos`

Exemplo de Payload:

```json
{
  "projeto": {
    "nome": "CRIANDO NOVO PROJETO",
    "avaliacoes_attributes": [
      {
        "media_ponderada": 0.0,
        "notas_attributes": [
          {
            "nota": 7.67,
            "criterio_id": 1 // Assumindo que o critério com ID 1 já exista
          },
          {
            "nota": 8.31,
            "criterio_id": 2 // Assumindo que o critério com ID 2 já exista
          }
        ]
      }
    ]
  }
}

```

### GET /projetos

Obtenha uma lista de projetos com suporte para paginação.

Exemplo da request: `http://localhost:3000/v1/projetos?page=1&per_page=100`

### POST /criterios

Cria um critério de avaliação.

Exemplo da request: `http://localhost:3000/v1/criterios`

Exemplo de Payload:

```json
{
  "criterio": {
    "peso": 10.0
  }
}
```
### PUT /criterios
Atualiza um critério de avaliação.

Exemplo da request: `http://localhost:3000/v1/criterios/10`

Exemplo do Payload:

```json
{
  "criterio": {
    "peso": 10.0
  }
}
```

## Executando os testes unitários

`docker-compose run --rm app rspec`

## Executando o Linter (Rubocop)

`docker-compose run --rm app rubocop`


## Encerrar os services
`docker stop $(docker ps -aq) && docker rm $(docker ps -qa) && docker-compose down`


## Tecnologias Utilizadas

- Ruby on Rails 7
- Mysql
- Docker e Docker Compose
- RSpec, FactoryBot e Shoulda Matechers para testes
- Rubocop para análise de código
