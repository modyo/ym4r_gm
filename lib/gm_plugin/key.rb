module Ym4r
  module GmPlugin
    class GMapsAPIKeyConfigFileNotFoundException < StandardError
    end
        
    class AmbiguousGMapsAPIKeyException < StandardError
    end
    
    #Class fo the manipulation of the API key
    class ApiKey
      
      cattr_accessor :key
     
      def self.get(options = {})

        raise "Not Google Maps key defined" unless @@key

        if options.has_key?(:key)
          options[:key]
        elsif @@key.is_a?(Hash)
          #For this environment, multiple hosts are possible.
          #:host must have been passed as option
          if options.has_key?(:host)
            @@key[options[:host]]
          else
            raise AmbiguousGMapsAPIKeyException.new(@@key.keys.join(","))
          end
        else
          #Only one possible key: take it and ignore the :host option if it is there
          @@key
        end
      end
      
    end
  end
end
