

module NewsApi

  class BaseRequest

    BASE_REQUEST_URL = 'https://newsapi.org/v1'
    SUCCESS 		 = 200

    attr_reader :api_key
    def initialize(api_key)
      @api_key = api_key
    end

    def get endpoint
      response = Faraday.get "#{BASE_REQUEST_URL}/#{endpoint}"
      if is_success?(response)
        parse response.body
      else
        raise failed_request response
      end
    end

    private

    def parse response
      JSON.parse response
    end

    def is_success? response
      response.status == SUCCESS
    end

    def failed_request response
      msg = "#{response.status}: #{response.reason_phrase}"
      NewsApi::Exceptions::FailedRequest.new msg
    end

  end
end