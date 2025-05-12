class PagesController < ApplicationController
  require "./app/services/elasticsearch/ingridients_query.rb"

  def home
      elasticsearch = Elasticsearch::IngridientsQuery.new(params[:ingredients])
      elasticsearch.response

      return @errors = elasticsearch.errors if elasticsearch.errors.present?
      @total_recipes = elasticsearch.result[:total]
      @recipes = Kaminari.paginate_array(elasticsearch.result[:recipes]).page(params[:page]).per(5)
  end

  private

  def page_params
    params.require(:page).permit(:ingredients)
  end
end
