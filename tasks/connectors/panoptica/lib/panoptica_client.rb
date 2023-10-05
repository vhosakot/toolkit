require_relative('./bootstrap')
require 'escher'
require 'net/http'
require 'json'

module Kenna
  module Toolkit
    module Panoptica
      class Client
        class ApiError < StandardError; end
        def initialize(client_id, client_secret, api_host)
          @image = {}
          @image_vulns = []
          http_get_image_vulns(client_id, client_secret, api_host)
        end

        def get_image_vulns()
            return @image_vulns
        end

        def get_image()
            return @image
        end

        private

        def http_get_image_vulns(client_id, client_secret, api_host)
          credentialscope = 'global/services/portshift_request'
          apikeyid = client_id
          apisecret = client_secret
          host = api_host
          port = 443
          # get all images
          reqpath = '/api/images'
          escher = Escher::Auth.new(credentialscope, {})
          request_data = {
              method: 'GET',
              uri: reqpath,
              headers: [['Content-Type', 'application/json'], ['host', host]]
          }
          escher.sign!(request_data, { api_key_id: apikeyid, api_secret: apisecret })
          request = Net::HTTP::Get.new(reqpath)
          request_data[:headers].each do |header|
            request[header.first] = header.last
          end
          http = Net::HTTP.new(host, port)
          http.use_ssl = true
          response = http.request(request)
          images = JSON.parse(response.body)

          images.each { |i|
              if i["id"] == "28ae66d3-a91d-4c30-be8b-d3ef1b31022e"
                  # get all vulnerabilities of image
                  @image = i
                  reqpath = '/api/images/28ae66d3-a91d-4c30-be8b-d3ef1b31022e/vulnerabilities'
                  escher = Escher::Auth.new(credentialscope, {})
                  request_data = {
                      method: 'GET',
                      uri: reqpath,
                      headers: [['Content-Type', 'application/json'], ['host', host]]
                  }
                  escher.sign!(request_data, { api_key_id: apikeyid, api_secret: apisecret })
                  request = Net::HTTP::Get.new(reqpath)
                  request_data[:headers].each do |header|
                    request[header.first] = header.last
                  end
                  http = Net::HTTP.new(host, port)
                  http.use_ssl = true
                  response = http.request(request)
                  @image_vulns = JSON.parse(response.body)
              end
          }

        end
      end
    end
  end
end
