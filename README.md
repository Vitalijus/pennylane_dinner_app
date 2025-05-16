<img alt="Rails" src="https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/> <img alt="Postgres" src ="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white"/> <img alt="ElasticSearch" src="https://img.shields.io/badge/-ElasticSearch-005571?style=for-the-badge&logo=elasticsearch&logoColor=white"/>

## Pennylane.com
This app is a technical assignment by pennylane.com. I did not pass the interview, but you can use the app as a base and improve it further. Good luck!

## Purpose
Coming up with meal ideas can be tricky when all you have is a fridge full of random ingredients. This app makes it easy — just enter the ingredients you have, and we'll find the best matching recipes for you. No more food waste or mealtime indecision!

## User Story 1: Find Recipes with Available Ingredients
**As a** home cook
**I want to** enter a list of ingredients I currently have
**So that** I can discover recipes I can cook without buying more groceries.

## User Story 2: See the Most Relevant Recipes First
**As a** user searching for recipes
**I want** to see the most relevant recipes based on my ingredients ranked by best match
**So that** I can quickly choose the most suitable recipe for dinner

## Getting Started
Visit running app on: https://dinner-app-f1dcb3f1cc03.herokuapp.com/.
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites

- Install [Ruby](https://www.ruby-lang.org/en/downloads/).
- Install [Postgres](https://www.postgresql.org/).
- Install [OpenSearch/ElasticSearch](https://opensearch.org/).

## Run the application

To run this project follow below steps:

Pull the application code from the github repo.
```sh
git clone git@github.com:Vitalijus/dinner_app.git
```

Install dependencies.
```sh
bundle install
```

Create, migrate and seed database.
```sh
rails db:prepare
```

## ElasticSearch

Create ElastiSearch index.
```sh
Recipe.__elasticsearch__.create_index!
```

Import data to the created index.
```sh
Recipe.import
```

### Visit

- Running app: [http://localhost:3000/](http://localhost:3000/)

## Running the tests

To run the whole test suite.
```sh
bundle exec rspec
```

## Authors

- **Vitalijus Desukas** - _Backend engineer_ -
  [Vitalijus](https://github.com/Vitalijus)
