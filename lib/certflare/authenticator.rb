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

module Cloudflare
  class Authenticator
    @@configs_dir = Pathname.new('/sites/configs/dns-cloudflare-credentials/')
    @@cfg         = ConfigParser.new(@@configs_dir.join('cloudflare.ini'))
    @@api_key     = @@cfg['dns_cloudflare_api_key']
    @@email       = @@cfg['dns_cloudflare_email']

    def self.get_certbot_vars
      @@domain     = ENV['CERTBOT_DOMAIN']
      @@validation = ENV['CERTBOT_VALIDATION']
    end

    def self.get_domain
      @@main_domain = PublicSuffix.domain(@@domain)
      # puts "root domain: #{@@main_domain}"
    end

    def self.get_zone_id
      zone      = CloudflareClient::Zone.new(auth_key: @@api_key, email: @@email).zones(name: @@main_domain)
      @@zone_id = zone[:result][0][:id]
      # puts "zone id: #{@@zone_id}"
    end

    def self.create_txt_record
      domain_with_prefix = "_acme-challenge.#{@@domain}"
      # puts "record name: #{domain_with_prefix}"
      dns_records = CloudflareClient::Zone::DNS.new(zone_id: @@zone_id, auth_key: @@api_key, email: @@email)
      record      = dns_records.create(name: domain_with_prefix, type: 'TXT', content: @@validation, ttl: 120)
      @@record_id = record[:result][:id]
      # puts "record id: #{@@record_id}"
    end

    def self.create_cleanup
      domain_dir = Pathname.new("/sites/tmp/CERTBOT_#{@@domain}")
      # puts "domain dir: #{domain_dir}"
      if !domain_dir.exist?
        Dir.mkdir(domain_dir, 0700)
      end
      zone_id_file   = domain_dir.join('ZONE_ID')
      record_id_file = domain_dir.join('RECORD_ID')
      File.open(zone_id_file, 'w') do |f|
        f.print(@@zone_id)
      end
      File.open(record_id_file, 'w') do |f|
        f.print(@@record_id)
      end
      # puts <<~HEREDOC
      #  details for #{zone_id_file.to_s}
      #  writable? #{File.writable?(zone_id_file)}
      #  readable? #{File.readable?(zone_id_file)}
      #HEREDOC
      #puts <<~HEREDOC
      #  details for #{record_id_file.to_s}
      #  writable? #{File.writable?(record_id_file)}
      #  readable? #{File.readable?(record_id_file)}
      #HEREDOC
    end
  end

  Authenticator.get_certbot_vars
  Authenticator.get_domain
  Authenticator.get_zone_id
  Authenticator.create_txt_record
  Authenticator.create_cleanup
  sleep 20
end