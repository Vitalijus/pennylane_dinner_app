class Elasticsearch::Base
  def search
    if Rails.env.production?
      client = Elasticsearch::Client.new(url: ENV.fetch("BONSAI_URL"), log: true)
    else
      client = Elasticsearch::Client.new(log: true)
    end

    client.search(index: "recipes", body: query)
  rescue Elasticsearch::Transport::Transport::Error => e
    Rails.logger.error("Elasticsearch::Transport::Transport::Error: #{e.message}")
    nil
  end

  def response
    response = search

    if response.nil?
      @errors = "Item couldn't be found."
    elsif response.with_indifferent_access[:hits][:hits]
      @result = recipes_list(response.with_indifferent_access)
    else
      @errors = "Unexpected response: Please contact support."
    end
  end
end
