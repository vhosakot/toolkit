require_relative "lib/panoptica_client"
require 'json'
require 'fileutils'

module Kenna
  module Toolkit
    class PanopticaTask < Kenna::Toolkit::BaseTask
      def self.metadata
        {
          id: "panoptica",
          name: "PANOPTICA",
          description: "Pulls assets, vulnerabilities and issues from Cisco Panoptica",
          options: [
            { name: "panoptica_apikeyid",
              type: "string",
              required: true,
              default: nil,
              description: "Panoptica apikeyid" },
            { name: "panoptica_apisecret",
              type: "api_key",
              required: true,
              default: nil,
              description: "Panoptica apisecret" },
            { name: "panoptica_api_host",
              type: "hostname",
              required: true,
              default: nil,
              description: "Panoptica API host URL (example: appsecurity.cisco.com). If schema is included, it should be between double quotes escaped." },
            { name: "issues_external_id_attr",
              type: "string",
              required: false,
              default: nil,
              description: "For ISSUES, the entitySnapshot attribute used to map Kenna asset's external_id, for instance, `providerId` or `resourceGroupExternalId`. If not present or the value for the passed attribute is not present the provideId attribute value is used." },
            { name: "vulns_external_id_attr",
              type: "string",
              required: false,
              default: nil,
              description: "For VULNS, the `vulnerableEntity` attribute used to map Kenna asset's external_id, for instance, `id`, `providerUniqueId` or `name`. If not present or the value for the passed attribute is not present the `id` attribute value is used." },
            { name: "kenna_batch_size",
              type: "integer",
              required: false,
              default: 1000,
              description: "Maximum number of vulnerabilities to upload to Kenna in each batch. Increasing this value could improve performance." },
            { name: "kenna_api_key",
              type: "api_key",
              required: false,
              default: nil,
              description: "Kenna API Key" },
            { name: "kenna_api_host",
              type: "hostname",
              required: false,
              default: "api.kennasecurity.com",
              description: "Kenna API Hostname" },
            { name: "kenna_connector_id",
              type: "integer",
              required: false,
              default: nil,
              description: "If set, we'll try to upload to this connector" },
            { name: "output_directory",
              type: "filename",
              required: false,
              default: "output/panoptica",
              description: "If set, will write a file upon completion. Path is relative to #{$basedir}" }
          ]
        }
      end

      def run(opts)
        super
        initialize_options
        client = Panoptica::Client.new(@client_id, @client_secret, @api_host)
        panoptica_kdi = client.get_panoptica_kdi()

        dirname = File.dirname(@output_directory + '/panoptica')
        unless File.directory?(dirname)
          FileUtils.mkdir_p(dirname)
        end
        f = File.new(@output_directory + '/panoptica_kdi.json', 'w')
        f.write(panoptica_kdi.to_json + "\n")
        f.close
        puts "Cisco Panoptica KDI that can be uploaded to Kenna is created at #{dirname + '/panoptica_kdi.json'}"
      rescue Kenna::Toolkit::Sample::Client::ApiError => e
        fail_task e.message
      end

      private

      attr_reader :client

      def initialize_options
        @client_id = @options[:panoptica_apikeyid]
        @client_secret = @options[:panoptica_apisecret]
        @api_host = @options[:panoptica_api_host]
        @issues_external_id_attr = @options[:issues_external_id_attr]
        @vulns_external_id_attr = @options[:vulns_external_id_attr]
        @output_directory = @options[:output_directory]
        @kenna_api_host = @options[:kenna_api_host]
        @kenna_api_key = @options[:kenna_api_key]
        @kenna_connector_id = @options[:kenna_connector_id]
        @kenna_batch_size = @options[:kenna_batch_size].to_i
        @skip_autoclose = false
        @retries = 3
        @kdi_version = 2
      end
    end
  end
end
