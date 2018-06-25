#!/usr/bin/ruby

require_relative "./ducky.rb"

action = ARGV[0]
domain = ARGV[1]

duckydns_token_path = File.join(File.dirname(__FILE__), '/.apitoken')
unless File.exist?(duckydns_token_path)
    $stderr.puts "Need a DuckDNS tokey key in #{duckydns_token_path}"
    $stderr.puts "See https://www.duckdns.org/spec.jsp"
    exit
end

api_token = File.read(duckydns_token_path).strip()
d = Ducky.new(api_token)

case action
when "update"
    challenge = ARGV[2]
    d.set_acme_challenge(domain: domain, challenge: challenge)
when "cleanup"
    d.clear_acme_challenge(domain: domain)
end
