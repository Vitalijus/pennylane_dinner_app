class Recipe < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "recipes"

  # Elasticsearch
  # Heroku config is set to: ELASTICSEARCH_URL=https://paas:*************b31617@oin-us-east-1.searchly.com
  # Local is set to: ELASTICSEARCH_URL=http://localhost:9200
  # Recipe.__elasticsearch__.create_index! - to create a new index.
  # Recipe.import - to import data.
  # Recipe.import force: true - to delete index and import data.
end
