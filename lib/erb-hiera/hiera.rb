require "hiera"

module ErbHiera
  module Hiera
    def self.hiera(key)
      hiera = ErbHiera.hiera
      ::Hiera.logger = "noop"
      value = hiera.lookup(key, nil, ErbHiera.scope, nil, :priority)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if ErbHiera.options[:verbose]
      value
    end

    def self.hiera_array(key)
      hiera = ErbHiera.hiera
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
      hiera = ErbHiera.hiera
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
