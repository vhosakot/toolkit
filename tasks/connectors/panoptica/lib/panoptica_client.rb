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
          @panoptica_kdi = {}
          create_panoptica_kdi(client_id, client_secret, api_host)
        end

        def get_panoptica_kdi()
          return @panoptica_kdi
        end

        private

        def http_get(client_id, client_secret, api_host, reqpath)
          # http get using escher auth for panoptica
          credentialscope = 'global/services/portshift_request'
          apikeyid = client_id
          apisecret = client_secret
          host = api_host
          port = 443
          reqpath = reqpath
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
          return JSON.parse(response.body)
        end

        def create_panoptica_kdi(client_id, client_secret, api_host)
          kdi_assets = []
          kdi_vuln_defs = []
          p_images_mapper = Panoptica::Mapper.new()
          # get all images
          images = http_get(client_id, client_secret, api_host, '/api/images')
          puts "\ncreating KDI for #{images.length()} images"

          images.each { |i|
            puts "\n  creating KDI for image asset, image ID: #{i['id']}"
            # get all vulnerabilities for each image
            image_vulns = http_get(client_id, client_secret, api_host, '/api/images/' + i['id'] + '/vulnerabilities')
            puts "    creating KDI for #{image_vulns.length()} vulnerabilities"
            # if images has no vulnerabilities
            if image_vulns.length() == 0
                image_asset = p_images_mapper.map_image_asset(i, {})
                kdi_assets.append(image_asset)
            else
                # if images has vulnerabilities
                image_vulns.each { |v|
                  puts "    creating KDI for vulnerability ID #{v['id']}"
                  image_asset = p_images_mapper.map_image_asset(i, v)
                  image_vuln_def = p_images_mapper.map_image_vuln_def(v)
                  kdi_assets.append(image_asset)
                  kdi_vuln_defs.append(image_vuln_def)
                }
            end
          }

          puts "\nnumber of assets in KDI = #{kdi_assets.length()}"
          puts "number of vuln_defs in KDI = #{kdi_vuln_defs.length()}"
          @panoptica_kdi = p_images_mapper.map_panoptica_kdi(kdi_assets, kdi_vuln_defs)
        end

      end
    end
  end
end
