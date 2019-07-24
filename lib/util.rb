class Hash
  def contentstack_to_query(namespace = nil)
    collect do |key, value|
      value.contentstack_to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end

  def contentstack_symbolize_keys
    new_hash = {}
    self.each do |key,value|
      if [Hash, Array].include?(value.class)
        new_hash[key.to_sym] = value.contentstack_symbolize_keys
      else
        new_hash[key.to_sym] = value
      end
    end
    new_hash
  end
end

class Array
  def contentstack_to_query(key)
    prefix = "#{key}[]"
    collect { |value| value.contentstack_to_query(prefix) }.join '&'
  end

  def contentstack_symbolize_keys
    collect do |entry|
      if entry.class == Hash
        entry.contentstack_symbolize_keys
      else
        entry
      end
    end
  end
end

class String
  def contentstack_to_query(key)
    require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
    "#{CGI.escape(key.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Symbol
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end
end

class NilClass
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end
end

class TrueClass
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end

  def contentstack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class FalseClass
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end

  def contentstack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Integer
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end

  def contentstack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Numeric
  def contentstack_to_query(key)
    to_s.contentstack_to_query(key)
  end

  def contentstack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end
