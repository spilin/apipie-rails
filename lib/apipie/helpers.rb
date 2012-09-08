module Apipie
  module Helpers
    def markup_to_html(text)
      return "" if text.nil?
      if Apipie.configuration.markup.respond_to? :to_html
        Apipie.configuration.markup.to_html(text.strip_heredoc)
      else
        text.strip_heredoc
      end
    end

    attr_accessor :url_prefix

    def request_script_name
      Thread.current[:apipie_req_script_name] || ""
    end

    def request_script_name=(script_name)
      Thread.current[:apipie_req_script_name] = script_name
    end

    def full_url(path)
      unless @url_prefix
        @url_prefix = ""
        @url_prefix << request_script_name
        @url_prefix << Apipie.configuration.doc_base_url
      end
      path = path.sub(/^\//,"")
      ret = "#{@url_prefix}/#{path}"
      ret.insert(0,"/") unless ret =~ /\A[.\/]/
      ret.sub!(/\/*\Z/,"")
      ret
    end

  end
end
