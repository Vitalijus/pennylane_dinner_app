##################
# Run ElasticSearch locally. Command: opensearch
# Run Kibana locally http://localhost:5601/app/home#/. Command: kibana
##################

class Elasticsearch::IngridientsQuery < Elasticsearch::Base
  attr_reader :errors, :result

  # MINIMUM_SHOULD_MATCH = 1

  def initialize(ingridients)
    @ingridients = ingridients
  end

  private

  def recipes_list(response)
    {
      total: response[:hits][:total][:value],
      recipes: recipes(response)
    }
  end

  def recipes(response)
    response[:hits][:hits].map do |recipe|
      _source = recipe[:_source]

      {
        title: _source[:title],
        cook_time: _source[:cook_time],
        prep_time: _source[:prep_time],
        ingredients: _source[:ingredients],
        ratings: _source[:ratings],
        cuisine: _source[:cuisine],
        category: _source[:category],
        author: _source[:author],
        image: _source[:image],
      }
    end
  end

  def query
    {
      query: {
        match_all: {}
      }
    }
  end
end
