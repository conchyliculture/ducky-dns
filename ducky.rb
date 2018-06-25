#!/usr/bin/ruby

class Ducky
    require "net/http"

    class Ducky::Exception < Exception
    end

    def initialize(api_token)
        @api_token = api_token
    end

    def set_acme_challenge(domain:, challenge:)
        if domain =~/^(.+)\.duckdns\.org$/
            domain = $1.split(".")[-1]
        end
        uri = URI("https://www.duckdns.org/update?domains=#{domain}&token=#{@api_token}&txt=#{challenge}")
        fetch_uri(uri:uri)
    end

    def clear_acme_challenge(domain:)
        if domain =~/^(.+)\.duckdns\.org$/
            domain = $1.split(".")[-1]
        end
        uri = URI("https://www.duckdns.org/update?domains=#{domain}&token=#{@api_token}&txt=whatevs&clear=true")
        fetch_uri(uri:uri)
    end

    # Private

    def fetch_uri(uri:)
        req = Net::HTTP::Get.new(uri)
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        res = http.request(req)
        case res.code
        when "403"
            $stderr.puts "Maybe wrong API token"
            raise Ducky::Exception.new(res)
        end
        case res.body
        when "KO"
            raise Ducky::Exception.new("DuckDNS is not happy")
        when "OK"
            # Yay
        else
            raise Ducky::Exception.new("Unexpected DuckDNS answer: #{res.body}")
        end
    end
end

