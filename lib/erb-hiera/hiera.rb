require "hiera"

module ErbHiera
  module Hiera
    def self.hiera(key)
      hiera = ::Hiera.new(:config => ErbHiera.options[:hiera_config])
      ::Hiera.logger = "noop"
      if ErbHiera.cache.has_key?("single_#{key}") then
        value = ErbHiera.cache["single_#{key}"]
      else
        value = hiera.lookup(key, nil, ErbHiera.scope, nil, :priority)
        ErbHiera.cache["single_#{key}"] = value
      end

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if ErbHiera.options[:verbose]
      value
    end

    def self.hiera_array(key)
      hiera = ::Hiera.new(:config => ErbHiera.options[:hiera_config])
      ::Hiera.logger = "noop"
      value = hiera.lookup(key, nil, ErbHiera.scope, nil, :array)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if ErbHiera.options[:verbose]
      value
    end

    def self.hiera_hash(key)
      hiera = ::Hiera.new(:config => ErbHiera.options[:hiera_config])
      ::Hiera.logger = "noop"
      value = hiera.lookup(key, nil, ErbHiera.scope, nil, :hash)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if ErbHiera.options[:verbose]
      value
    end

    def self.get_binding
      binding
    end
  end
end
