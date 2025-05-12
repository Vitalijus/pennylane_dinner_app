require 'rails_helper'

RSpec.describe Elasticsearch::IngridientsQuery do
  let(:ingredients) { "chicken tomato" }
  let(:service) { described_class.new(ingredients) }

  describe "#initialize" do
    it "formats the ingredients on init" do
      expect(service.instance_variable_get(:@ingridients)).to eq("chicken tomato")
    end

    it "handles nil ingredients" do
      expect(described_class.new(nil).instance_variable_get(:@ingridients)).to eq("")
    end
  end

  describe "#response (integration with parent)" do
    let(:mock_hits) do
      [
        {
          _source: {
            title: "Chicken Soup",
            cook_time: 30,
            prep_time: 10,
            ingredients: ["chicken", "water", "salt"],
            ratings: 4.5,
            cuisine: "American",
            category: "Soup",
            author: "Chef John",
            image: "chicken_soup.jpg"
          }
        }
      ]
    end

    let(:mock_response) do
      {
        hits: {
          total: { value: 1 },
          hits: mock_hits
        }
      }.with_indifferent_access
    end

    before do
      allow(service).to receive(:search).and_return(mock_response)
    end

    it "sets the result as parsed recipe list" do
      service.response

      expect(service.result).to eq({
        total: 1,
        recipes: [
          {
            title: "Chicken Soup",
            cook_time: 30,
            prep_time: 10,
            ingredients: ["chicken", "water", "salt"],
            ratings: 4.5,
            cuisine: "American",
            category: "Soup",
            author: "Chef John",
            image: "chicken_soup.jpg"
          }
        ]
      })
    end
  end

  describe "#query" do
    it "returns the correct query body" do
      expected_query = {
        query: {
          match: {
            ingredients: {
              query: ingredients,
              operator: "and",
              fuzziness: "AUTO"
            }
          }
        },
        size: 1000
      }

      expect(service.send(:query)).to eq(expected_query)
    end
  end
end
