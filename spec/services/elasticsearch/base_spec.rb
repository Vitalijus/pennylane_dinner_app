require 'rails_helper'
require 'pry'

RSpec.describe Elasticsearch::Base do
  let(:service) { described_class.new }
  let(:ingridients) { Elasticsearch::IngridientsQuery.new("milk, corn, beef") }

  describe "#search" do
    context "in production" do
      before do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
        stub_const("ENV", ENV.to_hash.merge("BONSAI_URL" => "http://fake-bonsai.com"))
        allow(ingridients).to receive(:query).and_return({})
      end

      it "initializes Elasticsearch client with BONSAI_URL" do
        expect(Elasticsearch::Client).to receive(:new).with(url: "http://fake-bonsai.com", log: true).and_return(double(search: {}))
        ingridients.search
      end
    end

    context "in development" do

      before do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("development"))
        allow(ingridients).to receive(:query).and_return({})
      end

      it "initializes Elasticsearch client without URL" do
        expect(Elasticsearch::Client).to receive(:new).with(log: true).and_return(double(search: {}))
        ingridients.search
      end
    end

    it "logs error and returns nil if search fails" do
      client = double
      allow(Elasticsearch::Client).to receive(:new).and_return(client)
      allow(client).to receive(:search).and_raise(Elasticsearch::Transport::Transport::Error.new("Oops"))
      expect(Rails.logger).to receive(:error).with(/Elasticsearch::Transport::Transport::Error/)
      expect(ingridients.search).to be_nil
    end
  end

  describe "#response" do
    context "when search returns nil" do
      it "sets @errors with not found message" do
        allow(service).to receive(:search).and_return(nil)
        service.response
        expect(service.instance_variable_get(:@errors)).to eq("Item couldn't be found.")
      end
    end
  end
end
