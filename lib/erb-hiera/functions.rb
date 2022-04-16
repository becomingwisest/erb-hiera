require "hiera"

module ErbHiera
  class Functions
    def initialize(config,scope,verbose)
      @hiera = ::Hiera.new(:config => ErbHiera.options[:hiera_config])
      @scope = scope
      @verbose = verbose
    end
    def hiera(key)
      ::Hiera.logger = "noop"
      value = @hiera.lookup(key, nil, @scope, nil, :priority)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def self.hiera_array(key)
      ::Hiera.logger = "noop"
      value = @hiera.lookup(key, nil, @scope, nil, :array)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def self.hiera_hash(key)
      ::Hiera.logger = "noop"
      value = @hiera.lookup(key, nil, @scope, nil, :hash)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def self.get_binding
      binding
    end
  end
end
