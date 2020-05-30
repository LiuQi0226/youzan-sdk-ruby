# -*- coding: utf-8 -*-
require "youzan/sdk/version"
require "youzan/sdk/api_operations/customer.rb"
require "youzan/sdk/base"
require "youzan/sdk/item"
require "youzan/sdk/users"
require "youzan/sdk/ump"
require "youzan/sdk/order_manage"

require 'typhoeus'
require 'json'

module Youzan
  class Configuration
    attr_accessor :app_id, :app_secret, :grant_id, :api_host, :token_info

    def initialize
      @api_host = 'https://open.youzanyun.com/api'
      @app_id = nil
      @app_secret = nil
      @grant_id = nil # 店铺id
      @token_info = nil
    end
  end

  class << self
    # attr_writer :debug_mode
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def api_host
      configuration.api_host
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
      _request = Typhoeus::Request.new(
        api,
        method: method,
        body: body.to_json,
        params: verify ? {:access_token => app_token} : {:access_token => nil},
        headers: {
            "Content-Type": 'application/json'
        }
      )
      JSON.parse _request.run.body
    end

    def refresh_token
      body = {
        "authorize_type": "silent",
        "client_id": configuration.app_id,
        "client_secret": configuration.app_secret,
        "grant_id": configuration.grant_id
      }
      result = send_request(:post, "https://open.youzanyun.com/auth/token", body, false)
      unless result["success"] # 不成功则return
        puts result
        return
      end
      write_token(result)
      result["data"]["access_token"]
    end


    private
    def read_token
      JSON.parse(configuration.token_info)
    rescue
      {}
    end

    def write_token(token_hash)
      configuration.token_info = token_hash.to_json
    end
  end
end