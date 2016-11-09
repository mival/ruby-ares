# encoding: utf-8

require 'net/http'

module RubyARES
  class HTTP

    class ConnectionError < StandardError; end

    def self.fetch_subject_xml(ic, url = 'http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_bas.cgi')
      # Get a subject info from ARES[http://wwwinfo.mfcr.cz/ares/]
      uri = URI(url)
      params = { :ico => ic, :version => '1.0.3' }
      uri.query = URI.encode_www_form(params)

      begin
        res = Net::HTTP.get_response uri
        @xml = res.body if res.is_a? Net::HTTPSuccess
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        raise ConnectionError, e
      end
    end
  end
end
