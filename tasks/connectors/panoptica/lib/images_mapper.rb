module Kenna
  module Toolkit
    module Panoptica
      class Mapper
        def initialize()
          @images_vuln_map = {}
        end

        def get_images_vuln_map()
            return @images_vuln_map
        end

        def set_images_vuln_map(image, image_vulns)
          @images_vuln_map = {
            "skip_autoclose": false,
            "version": 2,
            "assets": [
              {
                "image_id" => image["id"],
                "asset_type": "image",
                "hostname": "hostname",
                "tags" => [image["imageHash"]],
                "url" => image["imageName"],
                "application": "calico",
                "priority": 0,
                "vulns": [
                  {
                    "scanner_identifier": 16,
                    "vuln_def_name" => image_vulns["name"],
                    "scanner_type": "Cisco Panoptica",
                    "created_at" => image["timeAdded"],
                    "last_seen_at" => image["timeAdded"],
                    "due_date" => image["timeAdded"],
                    "status": "open",
                    "details" => image_vulns["description"],
                    "scanner_score" => image_vulns["cvssInfo"][0]["score"].to_i
                  }
                ],
                "findings": [
                  {
                    "scanner_identifier": 16,
                    "vuln_def_name" => image_vulns["name"],
                    "scanner_type": "Cisco Panoptica",
                    "created_at" => image["timeAdded"],
                    "last_seen_at" => image["timeAdded"],
                    "due_date" => image["timeAdded"],
                    "triage_state": "new",
                    # panoptica's severity (in response from /api/images/<image ID>/vulnerabilities' API)
                    # is string, but kenna's severity is integer in KDI per
                    # https://help.kennasecurity.com/hc/en-us/articles/360026413111
                    # "severity" => image_vulns["severity"],
                    "additional_fields": {
                      "test_field": "test data"
                    }
                  }
                ]
              }
            ],
            "vuln_defs": [
              {
                "name" => image_vulns["name"],
                "description" => image_vulns["description"],
                "scanner_type": "Cisco Panoptica",
                "cve_identifiers" => image_vulns["name"],
                "solution" => image_vulns["vulnerabilitySources"]["fixAvailability"]
              }
            ]
          }
        end
      end
    end
  end
end
