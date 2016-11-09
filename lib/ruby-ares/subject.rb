# encoding: utf-8

require 'ruby-ares/parser'
require 'ruby-ares/http'

module RubyARES
  class Subject
    attr_reader :ico,       # ICO
                :ic,        # alias for ic
                :dic,       # DIC
                :name,      # Obchodni_firma
                :company,   # alias for name
                :legal_form,# Pravni forma
                :status,    # Stav
                :addresses,
                :updated_at # Datum_zmeny

    def self.get(ic, url = 'http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_bas.cgi')
      xml = RubyARES::HTTP.fetch_subject_xml(ic, url)
      RubyARES::Parser.get_subject xml
    end

    def initialize(ic, dic, name, status, addresses, updated_at, legal_form)
      @ic, @ico = ic, ic
      @dic = dic
      @name, @company = name
      @status = status
      @addresses = addresses
      @updated_at = updated_at
      @legal_form = legal_form
    end

    def address
      @addresses[0]
    end
  end
end
