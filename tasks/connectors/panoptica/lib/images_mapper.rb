module Kenna
  module Toolkit
    module Panoptica
      class Mapper

        def map_image_asset(image, image_vuln)
          # if images has no vulnerabilities
          if image_vuln == {}
            image_asset = {
                "image_id" => image["id"],
                "asset_type": "image",
                "hostname" => image["imageName"],
                "tags" => [image["imageHash"]],
                "url" => image["imageName"],
                "application" => image["imageName"],
                "priority": 0,
                "vulns": [],
                "findings": []
            }
          else
            # if image has vulnerabilities
            image_asset = {
              "image_id" => image["id"],
              "asset_type": "image",
              "hostname" => image["imageName"],
              "tags" => [image["imageHash"]],
              "url" => image["imageName"],
              "application" => image["imageName"],
              "priority": 0,
              "vulns": [
                {
                  "scanner_identifier": 16,
                  "vuln_def_name" => image_vuln["name"],
                  "scanner_type": "Cisco Panoptica",
                  "created_at" => image["timeAdded"],
                  "last_seen_at" => image["timeAdded"],
                  "due_date" => image["timeAdded"],
                  "status": "open",
                  "details" => image_vuln["description"],
                  "scanner_score" => image_vuln["cvssInfo"][0]["score"].to_i
                }
              ],
              "findings": [
                {
                  "scanner_identifier": 16,
                  "vuln_def_name" => image_vuln["name"],
                  "scanner_type": "Cisco Panoptica",
                  "created_at" => image["timeAdded"],
                  "last_seen_at" => image["timeAdded"],
                  "due_date" => image["timeAdded"],
                  "triage_state": "new",
                  # panoptica's severity (in response from /api/images/<image ID>/vulnerabilities' API)
                  # is string, but kenna's severity is integer in KDI per
                  # https://help.kennasecurity.com/hc/en-us/articles/360026413111
                  # "severity" => image_vuln["severity"],
                  "additional_fields": {
                    "test_field": "test data"
                  }
                }
              ]
            }
          end
          return image_asset
        end

        def map_image_vuln_def(image_vuln)
          image_vuln_def = {
            "name" => image_vuln["name"],
            "description" => image_vuln["description"],
            "scanner_type": "Cisco Panoptica",
            "cve_identifiers" => image_vuln["name"],
            "solution" => image_vuln["vulnerabilitySources"]["fixAvailability"]
          }
          return image_vuln_def
        end

        def map_panoptica_kdi(kdi_assets, kdi_vuln_defs)
          # documentation about KDI: https://help.kennasecurity.com/hc/en-us/articles/360026413111
          panoptica_kdi = {
            "skip_autoclose": false,
            "version": 2,
            "assets" => kdi_assets,
            "vuln_defs" => kdi_vuln_defs
          }
          return panoptica_kdi
        end

      end
    end
  end
end
