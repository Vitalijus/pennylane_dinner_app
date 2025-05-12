class Elasticsearch::Base
  def search
    elasticsearch_client.search(index: "recipes", body: query)
  rescue Elasticsearch::Transport::Transport::Error => e
    Rails.logger.error("Elasticsearch::Transport::Transport::Error: #{e.message}")
    nil
  end

  def response
    res = search
    return @errors = "Item couldn't be found." if res.nil?
    @result = recipes_list(res.with_indifferent_access)
  end

  private

  def elasticsearch_client
    options = { log: true }
    options[:url] = ENV.fetch("BONSAI_URL") if Rails.env.production?
    Elasticsearch::Client.new(**options)
  end
end
