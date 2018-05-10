class GithubService
  def initialize
    @headers = { authorization: "token #{ENV['TOKEN']}" }
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
    attr_reader :headers

    def conn
      Faraday.new('https://api.github.com', headers: headers)
    end
end
