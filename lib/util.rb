class Hash
  def content_stack_to_query(namespace = nil)
    collect do |key, value|
      value.content_stack_to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end

  def content_stack_symbolize_keys
    new_hash = {}
    self.each do |key,value|
      if [Hash, Array].include?(value.class)
        new_hash[key.to_sym] = value.content_stack_symbolize_keys
      else
        new_hash[key.to_sym] = value
      end
    end
    new_hash
  end
end

class Array
  def content_stack_to_query(key)
    prefix = "#{key}[]"
    collect { |value| value.content_stack_to_query(prefix) }.join '&'
  end

  def content_stack_symbolize_keys
    collect do |entry|
      if entry.class == Hash
        entry.content_stack_symbolize_keys
      else
        entry
      end
    end
  end
end

class String
  def content_stack_to_query(key)
    require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
    "#{CGI.escape(key.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Symbol
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end
end

class NilClass
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end
end

class TrueClass
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end

  def content_stack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class FalseClass
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end

  def content_stack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Integer
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end

  def content_stack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end

class Numeric
  def content_stack_to_query(key)
    to_s.content_stack_to_query(key)
  end

  def content_stack_to_query(val)
    "#{CGI.escape(val.to_s)}=#{CGI.escape(to_s)}"
  end
end
