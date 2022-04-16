require "hiera"

module ErbHiera
  class Functions
    def initialize(config,scope,verbose)
      @hiera = ::Hiera.new(:config => ErbHiera.options[:hiera_config])
      @scope = scope
      @verbose = verbose
      @cache = {}
    end
    def hiera(key)
      ::Hiera.logger = "noop"

      if @cache.has_key?("single_#{key}") then
        value = @cache["single_#{key}"]
      else
        value = @hiera.lookup(key, nil, @scope, nil, :priority)
        @cache["single_#{key}"] = value
      end
      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def hiera_array(key)
      ::Hiera.logger = "noop"
      value = @hiera.lookup(key, nil, @scope, nil, :array)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def hiera_hash(key)
      ::Hiera.logger = "noop"
      value = @hiera.lookup(key, nil, @scope, nil, :hash)

      unless value
        puts "\nerror: cannot find value for key: #{key}"
        exit 1
      end

      puts "# #{key}: #{value}" if @verbose
      value
    end

    def get_binding
      binding
    end
  end
end
