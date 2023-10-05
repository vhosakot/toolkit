## Kenna connector for Cisco Panoptica

Import assets' vulnerability data from Cisco Panoptica into Kenna (Cisco Vulnerability Management) using KDI (Kenna Data Importer, https://help.kennasecurity.com/hc/en-us/articles/360026413111). In `kenna_screenshots` directory, there are Kenna GUI screenshots of Panoptica vulnerability data imported into Kenna using the KDI in `panoptica_kdi.json`.

Steps to run this connector:

 - install ruby version `3.2.2`
   - ubuntu: install ruby using `rbenv` and `ruby-build` plugin, refer https://github.com/rbenv/rbenv#basic-git-checkout and https://github.com/rbenv/rbenv#installing-ruby-versions (run `rbenv install 3.2.2` to install Ruby `3.2.2`)
   - macOS: refer https://www.ruby-lang.org/en/documentation/installation/#homebrew

 - run this connector
    ```
    git clone git@github.com:vhosakot/toolkit.git
    cd toolkit
    git checkout panoptica_connector
    bundle install

    $ ruby --version
    ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]

    < WIP output below >
    $ bundle exec ruby ./toolkit.rb task=panoptica panoptica_apikeyid=ec16c781-9f95-4a56-9ea4-906b31ef6baa panoptica_apisecret=jYzn8jCzf4PHU/dwJYyMfQ2vDiFXkhOBn0dDAZnYbCE= panoptica_api_host=appsecurity.cisco.com
    Running: Kenna::Toolkit::PanopticaTask
    [+] (20231018130854) Setting kenna_batch_size to default value: 1000
    [+] (20231018130854) Converting kenna_batch_size with input value nil to 1000.
    [+] (20231018130854) Setting kenna_api_host to default value: api.kennasecurity.com
    [+] (20231018130854) Setting output_directory to default value: output/panoptica
    [+] (20231018130854) Got option: task: panoptica
    [+] (20231018130854) Got option: panoptica_apikeyid: e*******baa
    [+] (20231018130854) Got option: panoptica_apisecret: j*******CE=
    [+] (20231018130854) Got option: panoptica_api_host: appsecurity.cisco.com
    [+] (20231018130854) Got option: kenna_batch_size: 1000
    [+] (20231018130854) Got option: kenna_api_host: api.kennasecurity.com
    [+] (20231018130854) Got option: output_directory: output/panoptica
    [+] (20231018130854) 
    [+] (20231018130854) Launching the PANOPTICA task!
    [+] (20231018130855) 
    
    image from panoptica = {
      "id": "28ae66d3-a91d-4c30-be8b-d3ef1b31022e",
      "imageName": "docker.io/calico/node",
      "imageTags": [
        null
      ],
      "imageHash": "8e34517775f319917a0be516ed3a373dbfca650d1ee8e72158087c24356f47fb",
      "timeAdded": "2023-09-06T14:28:49.011Z",
      "vulnerabilitiesSummary": {
        "total": 30,
        "unknown": 0,
        "low": 13,
        "medium": 16,
        "high": 0,
        "critical": 1
      },
      "isScanned": true,
      "isIdentified": false,
      "imageSourceType": "RUNTIME",
      "dockerfileScanResultsSummary": {
        "total": 0,
        "info": 0,
        "warn": 0,
        "fatal": 0
      },
      "licenses": [
        "GPLv2 or BSD",
        "GPLv2 and Artistic 2.0 and ISC",
        "GPLv3+ and GFDL",
        "LGPLv2",
        "GPLv3",
        "BSD",
        "GPLv2+ and LGPLv2+",
        "LGPLv2+",
        "GPLv2+ or LGPLv3+",
        "GPLv3+",
        "LGPLv2+ and MIT",
        "GPLv3+ and GPLv3+ with exceptions and GPLv2+ with exceptions and LGPLv2+ and BSD",
        "BSD or GPLv2+",
        "BSD with advertising",
        "OpenSSL and ASL 2.0",
        "Public Domain",
        "GPLv2 and GPLv2+ and LGPLv2+ and BSD with advertising and Public Domain",
        "GPLv2",
        "LGPLv2+ and LGPLv2+ with exceptions and GPLv2+ and GPLv2+ with exceptions and BSD and Inner-Net and ISC and Public Domain and GFDL",
        "MIT",
        "BSD and GPLv2+",
        "zlib and Boost",
        "BSD or GPLv2",
        "GPLv2+ and Public Domain",
        "GPLv2+",
        "pubkey"
      ]
    }
    
    image_vulns from panoptica = {
      "id": "6ce05dcd-2971-4af6-b4cd-59266c9d334b",
      "name": "CVE-2019-1010022",
      "description": "** DISPUTED ** GNU Libc current is affected by: Mitigation bypass. The impact is: Attacker may bypass stack guard protection. The component is: nptl. The attack vector is: Exploit stack buffer overflow vulnerability and use this bypass vulnerability to bypass stack guard. NOTE: Upstream comments indicate \"this is being treated as a non-security bug and no real threat.\"",
      "link": "https://access.redhat.com/security/cve/CVE-2019-1010022",
      "severity": "CRITICAL",
      "cvss": {
        "score": 0.0,
        "attackVector": "NETWORK",
        "attackComplexity": "HIGH",
        "privilegesRequired": "NONE",
        "userInteraction": "NONE",
        "scope": "UNCHANGED",
        "confidentialityImpact": "NONE",
        "integrityImpact": "NONE",
        "availabilityImpact": "NONE"
      },
      "cvssInfo": [
        {
          "score": 0.0,
          "vector": "CVSS:3.0/AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:N/A:N",
          "type": "",
          "source": "",
          "version": "3.0"
        }
      ],
      "vulnerabilitySources": {
        "fixAvailability": "NO_FIX",
        "sources": [
          {
            "packageName": "glibc-minimal-langpack",
            "packageVersion": "2.28-225.el8",
            "fixVersion": null
          },
          {
            "packageName": "glibc-common",
            "packageVersion": "2.28-225.el8",
            "fixVersion": null
          },
          {
            "packageName": "glibc",
            "packageVersion": "2.28-225.el8",
            "fixVersion": null
          }
        ]
      },
      "layerName": null,
      "snoozedUntil": null
    }
    
    kenna kdi map = {
      "skip_autoclose": false,
      "version": 2,
      "assets": [
        {
          "image_id": "28ae66d3-a91d-4c30-be8b-d3ef1b31022e",
          "asset_type": "image",
          "hostname": "hostname",
          "tags": [
            "8e34517775f319917a0be516ed3a373dbfca650d1ee8e72158087c24356f47fb"
          ],
          "url": "docker.io/calico/node",
          "application": "calico",
          "priority": 0,
          "vulns": [
            {
              "scanner_identifier": 16,
              "vuln_def_name": "CVE-2019-1010022",
              "scanner_type": "Cisco Panoptica",
              "created_at": "2023-09-06T14:28:49.011Z",
              "last_seen_at": "2023-09-06T14:28:49.011Z",
              "due_date": "2023-09-06T14:28:49.011Z",
              "status": "open",
              "details": "** DISPUTED ** GNU Libc current is affected by: Mitigation bypass. The impact is: Attacker may bypass stack guard protection. The component is: nptl. The attack vector is: Exploit stack buffer overflow vulnerability and use this bypass vulnerability to bypass stack guard. NOTE: Upstream comments indicate \"this is being treated as a non-security bug and no real threat.\"",
              "scanner_score": 0
            }
          ],
          "findings": [
            {
              "scanner_identifier": 16,
              "vuln_def_name": "CVE-2019-1010022",
              "scanner_type": "Cisco Panoptica",
              "created_at": "2023-09-06T14:28:49.011Z",
              "last_seen_at": "2023-09-06T14:28:49.011Z",
              "due_date": "2023-09-06T14:28:49.011Z",
              "triage_state": "new",
              "additional_fields": {
                "test_field": "test data"
              }
            }
          ]
        }
      ],
      "vuln_defs": [
        {
          "name": "CVE-2019-1010022",
          "description": "** DISPUTED ** GNU Libc current is affected by: Mitigation bypass. The impact is: Attacker may bypass stack guard protection. The component is: nptl. The attack vector is: Exploit stack buffer overflow vulnerability and use this bypass vulnerability to bypass stack guard. NOTE: Upstream comments indicate \"this is being treated as a non-security bug and no real threat.\"",
          "scanner_type": "Cisco Panoptica",
          "cve_identifiers": "CVE-2019-1010022",
          "solution": "NO_FIX"
        }
      ]
    }
    
    $ cat panoptica_kdi.json | jq
    {
      "skip_autoclose": false,
      "version": 2,
      "assets": [
        {
          "image_id": "28ae66d3-a91d-4c30-be8b-d3ef1b31022e",
          "asset_type": "image",
          "hostname": "hostname",
          "tags": [
            "8e34517775f319917a0be516ed3a373dbfca650d1ee8e72158087c24356f47fb"
          ],
          "url": "docker.io/calico/node",
          "application": "calico",
          "priority": 0,
          "vulns": [
            {
              "scanner_identifier": 16,
              "vuln_def_name": "CVE-2019-1010022",
              "scanner_type": "Cisco Panoptica",
              "created_at": "2023-09-06T14:28:49.011Z",
              "last_seen_at": "2023-09-06T14:28:49.011Z",
              "due_date": "2023-09-06T14:28:49.011Z",
              "status": "open",
              "details": "** DISPUTED ** GNU Libc current is affected by: Mitigation bypass. The impact is: Attacker may bypass stack guard protection. The component is: nptl. The attack vector is: Exploit stack buffer overflow vulnerability and use this bypass vulnerability to bypass stack guard. NOTE: Upstream comments indicate \"this is being treated as a non-security bug and no real threat.\"",
              "scanner_score": 0
            }
          ],
          "findings": [
            {
              "scanner_identifier": 16,
              "vuln_def_name": "CVE-2019-1010022",
              "scanner_type": "Cisco Panoptica",
              "created_at": "2023-09-06T14:28:49.011Z",
              "last_seen_at": "2023-09-06T14:28:49.011Z",
              "due_date": "2023-09-06T14:28:49.011Z",
              "triage_state": "new",
              "additional_fields": {
                "test_field": "test data"
              }
            }
          ]
        }
      ],
      "vuln_defs": [
        {
          "name": "CVE-2019-1010022",
          "description": "** DISPUTED ** GNU Libc current is affected by: Mitigation bypass. The impact is: Attacker may bypass stack guard protection. The component is: nptl. The attack vector is: Exploit stack buffer overflow vulnerability and use this bypass vulnerability to bypass stack guard. NOTE: Upstream comments indicate \"this is being treated as a non-security bug and no real threat.\"",
          "scanner_type": "Cisco Panoptica",
          "cve_identifiers": "CVE-2019-1010022",
          "solution": "NO_FIX"
        }
      ]
    }
    ```
