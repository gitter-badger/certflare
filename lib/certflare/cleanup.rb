# 
# Copyright 2019 Ken Spencer / IotaSpencer
#
# 
# File: ${FILENAME}
# Created: 3/14/19
#
# License is in project root, MIT License is in use.
require 'cloudflare_client'
require 'configparser'
require 'pathname'
require 'public_suffix'

module Certflare
  class CleanUp
    @@configs_dir = Pathname.new('/sites/configs/dns-cloudflare-credentials/')
    @@cfg = ConfigParser.new(@@configs_dir.join('cloudflare.ini'))
    @@api_key = @@cfg['dns_cloudflare_api_key']
    @@email = @@cfg['dns_cloudflare_email']
    @@client = CloudflareClient::Zone.new(auth_key: @@api_key, email: @@email)
    def self.get_certbot_vars
      @@domain = ENV['CERTBOT_DOMAIN']
      @@validation = ENV['CERTBOT_VALIDATION']
    end
    def self.get_domain
      domain = ENV['CERTBOT_DOMAIN']
      @@full_domain = domain
      @@main_domain = PublicSuffix.domain(domain)
    end
    def self.remove_zone_id
      @@domain_dir = Pathname.new("/sites/tmp/CERTBOT_#{@@domain}")
      if @@domain_dir.join('ZONE_ID').exist?
        @@zone_id = File.read(@@domain_dir.join('ZONE_ID').to_s)
        File.delete(@@domain_dir.join('ZONE_ID').to_s)
      end
    end
    def self.remove_record_id
      if @@domain_dir.join('RECORD_ID').exist?
        @@record_id = File.read(@@domain_dir.join('RECORD_ID').to_s)
        File.delete(@@domain_dir.join('RECORD_ID').to_s)
      end
    end
    def self.remove_txt_record
      unless (defined?(@@zone_id)).nil?
        unless (defined?(@@record_id)).nil?
          zone = CloudflareClient::Zone::DNS.new(auth_key: @@api_key, email: @@email, zone_id: @@zone_id)
          zone.delete(id: @@record_id)
        end
      end
    end
  end
  CleanUp.get_certbot_vars
  CleanUp.get_domain
  CleanUp.remove_zone_id
  CleanUp.remove_record_id
  CleanUp.remove_txt_record

end