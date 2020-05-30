require "youzan/sdk/version"
require "youzan/sdk/api_operations/customer.rb"
require "youzan/sdk/base"
require "youzan/sdk/item"
require "youzan/sdk/users"
require "youzan/sdk/ump"

require 'typhoeus'
require 'json'

module Youzan
  class << self
    API_HOST = 'https://open.youzanyun.com/api'
    attr_accessor :app_id, :app_secret, :grant_id, :api_host, :token_file
    # attr_writer :debug_mode

    def api_host
      unless @api_host
        return API_HOST
      end
      @api_host
    end

    def app_token
      token_info = read_token
      if token_info["data"].nil?
        @app_token = refresh_token
      else
        @app_token = refresh_token if Time.now.to_i - 3600 > (token_info["data"]["expires"] / 1000)
        @app_token = token_info["data"]["access_token"]
      end
    end

    def send_request(method, api, body, verify)
      # params = 
      _request = Typhoeus::Request.new(
        api,
        method: method,
        body: body.to_json,
        # params: verify ? {:access_token => app_token} : {:access_token => nil},
        headers: {
          "Content-Type": 'application/json'
        },
        # verbose: true
      )
      JSON.parse _request.run.body
    end

    def refresh_token
      body = {
        "authorize_type": "silent",
        "client_id": app_id,
        "client_secret": app_secret,
        "grant_id": grant_id
      }
      result = send_request(:post, "https://open.youzanyun.com/auth/token", body, false)
      write_token(result)
      result["data"]["access_token"]
    end
    
    
    private
    def read_token
      JSON.parse(File.read(token_file))
    rescue
      {}
    end

    def write_token(token_hash)
      File.write(token_file, token_hash.to_json)
    end
    

    # def request(method='get', url=api_host, params={})
    #   Unirest.send(method, api_host + url, headers: generate_http_head, parameters: params).body
    # end

    # def debug_mode?
    #   @debug_mode.nil? ? true : !!@debug_mode
    # end
  end
end
