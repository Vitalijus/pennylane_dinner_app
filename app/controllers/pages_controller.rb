class PagesController < ApplicationController
  require "./app/services/elasticsearch/ingridients_query.rb"

  def home
    elasticsearch = Elasticsearch::IngridientsQuery.new(["milk", "eggs", "potato"])
    @recipes = elasticsearch.response
  end
end
