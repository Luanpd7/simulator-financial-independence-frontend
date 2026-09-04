# 📈 Simulador de Aposentadoria — Front-end

Aplicação web desenvolvida em **Flutter** para simulação de planejamento financeiro voltado à aposentadoria.

O usuário informa seus dados financeiros e objetivos de aposentadoria, e a aplicação apresenta os resultados calculados pelo back-end, incluindo indicadores financeiros e a evolução do patrimônio ao longo dos anos.

Este repositório contém o **front-end** da aplicação e se comunica com uma API REST desenvolvida em **Go (Golang)**.

## 🚀 Tecnologias

- **Flutter:** utilizado para desenvolvimento da interface da aplicação.
- **Dart:** linguagem utilizada no desenvolvimento do front-end.
- **REST API:** utilizada para comunicação entre o front-end e o back-end.
- **Clean Architecture:** utilizada para organização do projeto e separação de responsabilidades.
- **Git / GitHub:** utilizados para controle de versão e gerenciamento do código.
- **JIRA:** Para organização nas demandas.

## 📋 Funcionalidades

- Simulação de patrimônio para aposentadoria
- Definição do patrimônio atual
- Definição do aporte mensal
- Configuração da taxa de rentabilidade anual
- Configuração da inflação
- Definição da idade atual
- Definição da idade desejada para aposentadoria
- Simulação por período em anos
- Visualização do patrimônio final
- Visualização do patrimônio ajustado pela inflação
- Visualização da taxa de juros real
- Visualização do total contribuído
- Visualização dos rendimentos obtidos
- Cálculo do tempo até a aposentadoria
- Gráfico de evolução do patrimônio ao longo dos anos
- Comparação entre patrimônio nominal e patrimônio ajustado pela inflação

## 🧮 Indicadores da Simulação

Após o envio dos dados, a aplicação apresenta indicadores como:

- **Patrimônio final**
- **Patrimônio final ajustado pela inflação**
- **Taxa de juros real anual**
- **Taxa de juros real mensal**
- **Total contribuído**
- **Total de rendimentos**
- **Tempo até a aposentadoria**

## 📊 Evolução do Patrimônio

Além dos indicadores financeiros, a aplicação apresenta um gráfico com a evolução do patrimônio ao longo dos anos.

O gráfico permite acompanhar o efeito dos **juros compostos** sobre os investimentos e comparar:

- Crescimento nominal do patrimônio
- Crescimento do patrimônio ajustado pela inflação

## 🏗️ Estrutura do Projeto

```text
lib/
│
├── assets/
│
├── features/
│
└── main.dart
```

O projeto utiliza conceitos de **Clean Architecture**, buscando separar as responsabilidades da aplicação e facilitar sua manutenção e evolução.

## 🔄 Fluxo de Comunicação

```text
Flutter Web
     │
     │ HTTP / REST API
     ▼
Go REST API
     │
     │ Cálculos financeiros
     ▼
Resultado da Simulação
     │
     ▼
Flutter Web
     │
     ▼
Indicadores + Gráfico
```

## 💰 Conceitos Financeiros

A aplicação utiliza conceitos financeiros importantes para simulações de longo prazo, como:

- **Juros compostos**
- **Inflação**
- **Rentabilidade**
- **Taxa de juros real**
- **Aportes mensais**
- **Evolução patrimonial**
- **Planejamento para aposentadoria**

## 🔗 Back-end

Os cálculos financeiros são realizados por uma API REST desenvolvida em **Go (Golang)**.

Repositório do back-end:

https://lnkd.in/dfncngPj

## 🎯 Objetivo do Projeto

O projeto foi desenvolvido com o objetivo de aprimorar conhecimentos em **Flutter, Go, APIs REST e Clean Architecture**, aplicando esses conceitos em uma aplicação relacionada ao mercado financeiro.

Além dos conhecimentos de desenvolvimento de software, o projeto também permitiu aplicar conceitos financeiros como **juros compostos, juros reais, inflação, rentabilidade e planejamento de longo prazo**.
