class PagesController < ApplicationController
  require "./app/services/elasticsearch/ingridients_query.rb"

  def home
      elasticsearch = Elasticsearch::IngridientsQuery.new(params[:ingredients])
      @recipes = elasticsearch.response

  end

  private

  def page_params
    params.require(:page).permit(:ingredients)
  end
end
